# 360
A Ruby gem for connecting to the 360 Dianjing AD system, using the Open API Platform

## Install

    gem 'three-sixty', github: 'forward3d/three-sixty'


## Configuration

    require 'three-sixty'
    ThreeSixty.configure(logger: Logger.new($stdout))


## Retrieve Tokens

    require 'three-sixty'

    client = ThreeSixty::Client.new(api_key, api_secret)
    account = ThreeSixty::Account.new(client)
    account.client_login(username, password)

