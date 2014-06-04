module ThreeSixty
  module Core
    class Campaign

      SERVICE_URL = 'campaign'

      def initialize(client)
        @client = client
      end

      def get_info_by_id(campaign_id)
        @client.request(resource_url("getInfoById"), id: campaign_id)
      end

      def get_info_by_id_list(campaign_ids)
        @client.request(resource_url("getInfoByIdList"), idList: campaign_ids)
      end

      private

      def resource_url(service)
        [SERVICE_URL, service].join("/")
      end

    end
  end
end