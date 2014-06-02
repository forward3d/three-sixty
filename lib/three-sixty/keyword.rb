module ThreeSixty
  class Keyword

    SERVICE_URL = 'keyword'

    def initialize(client)
      @client = client
    end

    def get_id_list_by_group_id(ad_group_id)
      @client.request(resource_url("getIdListByGroupId"), groupId: ad_group_id)
    end

    def get_info_by_id(keyword_id)
      @client.request(resource_url("getInfoById"), id: keyword_id)
    end

    def get_status_by_id_list(keyword_ids)
      @client.request(resource_url("getStatusByIdList"), idList: keyword_ids)
    end

    def get_info_by_id_list(keyword_ids)
      @client.request(resource_url("getInfoByIdList"), idList: keyword_ids)
    end

    def get_changed_id_list(from_time)
      @client.request(resource_url("getChangedIdList"), fromTime: from_time)
    end

    private

    def resource_url(service)
      [SERVICE_URL, service].join("/")
    end

  end
end