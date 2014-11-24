require_relative 'client'

module ThreeSixty
  module Core
    class Creative
      include ThreeSixty::Core::Client

      SERVICE_URL = 'creative'

      def initialize(client)
        @client = client
      end

      def get_id_list_by_group_id(ad_group_id, opts = {})
        opts.merge!(groupId: ad_group_id)
        client_request(@client, resource_url("getIdListByGroupId"), opts)
      end

      def get_info_by_id(creative_id)
        client_request(@client, resource_url("getInfoById"), id: creative_id)
      end

      def get_info_by_id_list(creative_ids)
        client_request(@client, resource_url("getInfoByIdList"), idList: creative_ids)
      end

      def get_status_by_id_list(creative_ids)
        client_request(@client, resource_url("getStatusByIdList"), idList: creative_ids)
      end

      def get_changed_id_list(from_time)
        client_request(@client, resource_url("getChangedIdList"), fromTime: from_time)
      end

      private

      def resource_url(service)
        [SERVICE_URL, service].join("/")
      end

    end
  end
end