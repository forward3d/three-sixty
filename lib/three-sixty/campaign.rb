require_relative 'core/campaign'
require_relative 'account'

module ThreeSixty
  class Campaign < ThreeSixty::Core::Campaign

    def download_all_campaigns
      account = ThreeSixty::Account.new(@client)
      campaign_ids = account.download_campaign_ids
      get_info_by_id_list(campaign_ids)["campaignList"]
    end

  end
end