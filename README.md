# 360
A Ruby gem for connecting to the 360 Dianjing AD system, using the Open API Platform

## Install

    gem 'three-sixty', github: 'forward3d/three-sixty'


## Configuration

    require 'three-sixty'
    ThreeSixty.configure(logger: Logger.new($stdout))


## Authenticate

    require 'three-sixty'

    client = ThreeSixty::Client.new(api_key, api_secret)
    client.authenticate!(username, password)

## Get Campaign Ids

    require 'three-sixty'

    client = ThreeSixty::Client.new(api_key, api_secret)
    client.authenticate!(username, password)
    account.get_campaign_id_list