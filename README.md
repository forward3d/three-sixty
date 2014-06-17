# 360
A Ruby gem for connecting to the 360 Dianjing AD system, using the Open API Platform

## Install

Using bundler, add to your Gemfile

    gem 'three-sixty'


## Configuration

    require 'three-sixty'
    ThreeSixty.configure(logger: Logger.new($stdout))


## Authenticate

    require 'three-sixty'

    client = ThreeSixty::Client.new(api_key, api_secret)
    client.authenticate!(username, password)

  You can specify a hash of optional parameters when initializing the client. These include

    :endpoint - The 360 api endpoint (This is unlikely to change)
    :version  - The 360 api version number
    :format   - The api reponse format (Currently JSON or XML and is only useful when using the core library)
    :logger   - The client logger


## Get Campaign Ids

    require 'three-sixty'

    client = ThreeSixty::Client.new(api_key, api_secret)
    client.authenticate!(username, password)

    account = ThreeSixty::Account.new(client, opts)
    campaign_ids = account.download_campaign_ids

  You can specify a hash of optional parameters when initializing the account. These include

    :logger                    - Attach a local logger
    :report_generating_backoff - Create a lambda for your backoff strategy when polling the report generate e.g. lambda { |retry_number| [1 30 60 300].index(retry_number) }

## Streaming Campaign Ids to a File

    File.open('campaign_ids.csv', 'w') do |file|
      account.download_campaigns(campaign_ids) do |content|
        file.write content
      end
    end

## Download Campaign Ids to a File

    file = account.download_campaigns_to_file(campaign_ids, opts)

  You can specify a hash of optional parameters, which includes

    :download_dir - The directory to download the file
    :filename     - The full path of the file you wish to create
    :encoding     - The encoding used when downloading the file

## Download Campaign Info

    campaign = ThreeSixty::Campaign.new(client)
    campaign_info = campaign.download_all_campaigns


## Download All Ad Groups for a Campaign

    group = ThreeSixty::Group.new(client)
    group_info = group.download_campaign_all_ad_groups(campaigns_id)

## Download All Creatives for a Campaign

    group = ThreeSixty::Group.new(client)
    ad_group_ids = group.download_campaign_ad_group_ids(campaign_id)

    creatives = []
    creative = ThreeSixty::Creative.new(client)
    ad_group_ids.each do |ad_group_id|
      creatives += creative.download_ad_group_all_creatives(ad_group_id)
    end


## Downlod All Keywords for a Campaign

    group = ThreeSixty::Group.new(client)
    ad_group_ids = group.download_campaign_ad_group_ids(campaign_id)

    keywords = []
    keyword = ThreeSixty::Keyword.new(client)
    ad_group_ids.each do |ad_group_id|
      keywords += keyword.download_ad_group_all_keywords(ad_group_id)
    end
