require_relative 'client'

module ThreeSixty
  module Core
    class Group
      include ThreeSixty::Core::Client

      SERVICE_URL = 'group'

      def initialize(client)
        @client = client
      end

      def get_id_list_by_campaign_id(campaign_id, opts = {})
        opts.merge!(campaignId: campaign_id)
        client_request(@client, resource_url("getIdListByCampaignId"), opts)
      end

      def get_info_by_id(adgroup_id)
        client_request(@client, resource_url("getInfoById"), id: adgroup_id)
      end

      def get_info_by_id_list(adgroup_ids)
        client_request(@client, resource_url("getInfoByIdList"), idList: adgroup_ids)
      end

      private

      def resource_url(service)
        [SERVICE_URL, service].join("/")
      end

    end
  end
end