require 'net/http'
require 'securerandom'

require_relative 'core/account'

module ThreeSixty
  class Account < ThreeSixty::Core::Account

    attr_reader :report_generating_backoff, :logger

    def initialize(client, opts = {})
      opts = default_options.update(opts)

      @report_generating_backoff  = opts[:report_generating_backoff]
      @logger                     = opts[:logger] || client.logger

      super(client)
    end

    def download_campaign_ids
      get_campaign_id_list["campaignIdList"]
    end

    def download_campaigns(campaign_ids)
      file_id = get_all_objects(campaign_ids)['fileId']

      retry_number = 0
      file_state = get_file_state(file_id)
      while report_generating?(file_state["isGenerated"])
        begin
          @logger.debug "Waiting for report #{file_id} on retry number #{retry_number}"
          sleep report_generating_backoff.call(retry_number)
          retry_number += 1
          file_state = get_file_state(file_id)
        rescue TypeError => e
          e.message = "Waiting too long to generate the report #{file_id}" # Re-raise with a better error message
          raise e
        end
      end

      @logger.info "Found file #{file_state["filePath"]} with size #{"%.2f" % (file_state["fileSize"] / 2**20)} MB"
      download_filestream(file_state["filePath"]) { |chunk| yield chunk }
      @logger.info "Finished downloading file #{file_state["filePath"]}"
    end

    def download_campaigns_to_file(campaign_ids, opts = {})
      download_dir = opts[:download_dir] || "/tmp"
      file = opts[:filename] || File.join(download_dir, "306_campaigns_" << SecureRandom.uuid << ".csv")

      filemode = opts[:encoding].nil? ? 'w' : "w:#{opts[:encoding]}"

      @logger.debug "Creating file #{file} with filemode #{filemode}"
      File.open(file, filemode) do |fs|
        download_campaigns(campaign_ids) do |content|
          fs.write content
        end
      end

      @logger.info "Finished downloading file to #{file}"
      file
    end

    def exclude_ip_list
      get_exclude_ip["excludeIpList"]
    end


    private

    def report_generating?(status)
      [ 'pending', 'process'].include?(status)
    end

    def download_filestream(file)
      uri = URI(file)
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request_get(file) do |response|
          response.read_body { |chunk| yield chunk }
        end
      end
    end

    def default_options
      {
        report_generating_backoff: lambda { |retry_number| retry_number < 5 ? 2**retry_number : nil }
       }
    end

  end
end
