require_relative 'client'

module ThreeSixty
  module Core
    class Account
      include ThreeSixty::Core::Client

      SERVICE_URL = 'account'

      def initialize(client)
        @client = client
      end

      def client_login(username, password)
        client_request(@client, resource_url("clientLogin"), username: username, passwd: password)
      end

      def get_campaign_id_list
        client_request(@client, resource_url("getCampaignIdList"))
      end

      def get_info
        client_request(@client, resource_url("getInfo"))
      end

      def get_all_objects(campaign_ids)
        client_request(@client, resource_url("getAllObjects"), idList: campaign_ids)
      end

      def get_file_state(file_id)
        client_request(@client, resource_url("getFileState"), fileId: file_id)
      end

      def get_exclude_ip
        client_request(@client, resource_url("getExcludeIp"))
      end

      private

      def resource_url(service)
        [SERVICE_URL, service].join("/")
      end

    end
  end
end