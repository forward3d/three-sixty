require 'logger'

module ThreeSixty

  DEFAULT_ENDPOINT = "https://api.e.360.cn"
  DEFAULT_VERSION = "1.6"

  @@configuration = {}

  def self.configure(opts = {})
    @@configuration[:endpoint] = opts[:endpoint] || DEFAULT_ENDPOINT
    @@configuration[:version] = opts[:version] || DEFAULT_VERSION
    @@configuration[:logger] = opts[:logger] || Logger.new(nil)
  end

  def self.configuration
    @@configuration
  end
end