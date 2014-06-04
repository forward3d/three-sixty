require 'openssl'
require 'digest'
require 'base64'
require 'json'

require_relative 'core/account'

module ThreeSixty
  class Client

    attr_reader :api_key, :endpoint, :version, :logger
    attr_reader :access_token, :session_token

    def initialize(api_key, api_secret, opts = {})
      opts        = default_options.update(opts)

      @api_key    = api_key
      @api_secret = api_secret
      @endpoint   = opts[:endpoint]
      @version    = opts[:version]
      @format     = opts[:format]
      @logger     = opts[:logger]
    end

    def authenticate!(username, password)
      account = ThreeSixty::Core::Account.new(self)
      tokens = account.client_login(username, generate_passwd(password))
      @access_token = tokens['accessToken']
      @session_token = tokens['sessionToken']
    end

    def request(resource_url, params = {})
      params[:format] = @format
      uri = URI(generate_url(resource_url, params))
      @logger.debug "Resquest url #{uri.to_s}"
      req = Net::HTTP::Post.new(uri, headers = generate_headers)
      @logger.debug "Sending headers #{headers}"
      res = Net::HTTP.start(uri.host) do |http|
        http.request(req)
      end
      process_response(res)
    end

    private

    def default_options
      {
        endpoint: ThreeSixty.configuration[:endpoint],
        version:  ThreeSixty.configuration[:version],
        format:   ThreeSixty.configuration[:format],
        logger:   ThreeSixty.configuration[:logger]
       }
    end

    def serveToken
      DateTime.now.strftime("%Y%m%d%H%M%S%L")
    end

    def process_response(res)
      case res.content_type
      when 'application/json'
        process_json_response(res.body)
      else
        # raise "Unable to process response of type #{res.content_type}"
        res.body
      end
    end

    def process_json_response(content)
      JSON.parse(content)
    end

    def generate_headers
      headers = { 'serveToken' => serveToken, 'apiKey' => @api_key }
      headers['accessToken']  = @access_token unless @access_token.nil?
      headers['sessionToken'] = @session_token unless @session_token.nil?
      headers
    end

    def generate_passwd(password)
      encrypt(password).unpack("H2"*32).join
    end

    def encrypt(password)
      cipher = OpenSSL::Cipher::AES128.new(:CBC)
      cipher.encrypt
      cipher.key, cipher.iv = generate_key_and_vector(@api_secret)
      cipher.update(Digest::MD5.hexdigest(password)) + cipher.final
    end

    def generate_key_and_vector(secret)
      secret.scan(/.{16}/m).map { |s| Base64.decode64(Base64.encode64(s)) }
    end

    def generate_url(resource_url, query_params = {})
      endpoint = @endpoint + (resource_url.split("/")[1] == 'clientLogin' ? '/' : '/' << version) # client login doesn't contain version in the url
      [endpoint, resource_url].join('/') << '?' << querystring(query_params)
    end

    def querystring(query_params)
      query_params.map { |key, value| key.to_s << '=' << URI.escape(value.to_s) }.join('&')
    end

  end
end