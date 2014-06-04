module ThreeSixty
  module Core
    class Report

      SERVICE_URL = 'report'

      def initialize(client)
        @client = client
      end

      def keyword_count(start_date, level, opts = {})
        opts.merge!({startDate: start_date, level: level})
        @client.request(resource_url("keywordCount"), opts)
      end

      def keyword(start_date, level, opts = {})
        opts.merge!({startDate: start_date, level: level})
        @client.request(resource_url("keyword"), opts)
      end

      def creative_count(start_date, level, opts = {})
        opts.merge!({startDate: start_date, level: level})
        @client.request(resource_url("creativeCount"), opts)
      end

      def creative(start_date, level, opts = {})
        opts.merge!({startDate: start_date, level: level})
        @client.request(resource_url("creative"), opts)
      end

      def region_count(start_date, level, opts = {})
        opts.merge!({startDate: start_date, level: level})
        @client.request(resource_url("regionCount"), opts)
      end

      def region(start_date, level, opts = {})
        opts.merge!({startDate: start_date, level: level})
        @client.request(resource_url("region"), opts)
      end

      private

      def resource_url(service)
        [SERVICE_URL, service].join("/")
      end

    end
  end
end