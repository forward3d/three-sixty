require_relative 'core/creative'

module ThreeSixty
  class Creative < ThreeSixty::Core::Creative

    def download_ad_group_creative_ids(ad_group_id, opts = {})
      get_id_list_by_group_id(ad_group_id, opts)["creativeIdList"]
    end

    def download_ad_group_all_creatives(ad_group_id, opts = {})
      creative_ids = download_ad_group_creative_ids(ad_group_id, opts = {})
      return [] if creative_ids.empty?
      get_info_by_id_list(creative_ids.to_json)["creativeList"]
    end

    def download_ad_group_all_creative_statuses(ad_group_id, opts = {})
      creative_ids = download_ad_group_creative_ids(ad_group_id, opts = {})
      return [] if creative_ids.empty?
      get_status_by_id_list(creative_ids.to_json)["creativeList"]
    end

    def download_changed_creative_ids(from_time)
      get_changed_id_list(from_time)["creativeIdList"]
    end

  end
end