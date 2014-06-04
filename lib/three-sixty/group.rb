require_relative 'core/group'
require_relative 'account'

module ThreeSixty
  class Group < ThreeSixty::Core::Group

    def download_campaign_ad_group_ids(campaign_id, opts = {})
      get_id_list_by_campaign_id(campaign_id, opts)["groupIdList"]
    end

    def download_campaign_all_ad_groups(campaign_id, opts = {})
      ad_group_ids = download_campaign_ad_group_ids(campaign_id)
      get_info_by_id_list(ad_group_ids)["groupList"]
    end

  end
end