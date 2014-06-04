require_relative 'core/keyword'

module ThreeSixty
  class Keyword < ThreeSixty::Core::Keyword

    def download_ad_group_keyword_ids(ad_group_id, opts = {})
      get_id_list_by_group_id(ad_group_id, opts)["keywordIdList"]
    end

    def download_ad_group_all_keywords(ad_group_id, opts = {})
      keyword_ids = download_ad_group_keyword_ids(ad_group_id)
      return [] if keyword_ids.empty?
      get_info_by_id_list(keyword_ids)["keywordList"]
    end

    def download_ad_group_all_keyword_statuses(ad_group_id, opts = {})
      keyword_ids = download_ad_group_keyword_ids(ad_group_id)
      return [] if keyword_ids.empty?
      get_status_by_id_list(keyword_ids)["keywordList"]
    end

    def download_changed_keyword_ids(from_time)
      get_changed_id_list(from_time)["keywordIdList"]
    end

  end
end