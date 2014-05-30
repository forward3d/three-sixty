require 'openssl'
require 'digest'
require 'base64'

module ThreeSixty
  class Client

    attr_reader :api_key, :endpoint, :version, :logger

    def initialize(api_key, api_secret, opts = {})
      opts = default_options.update(opts)

      @api_key = api_key
      @api_secret = api_secret
      @endpoint = opts[:endpoint]
      @version = opts[:version]
      @logger = opts[:logger]
    end

    def request(resource_url, params = {})
      uri = URI(generate_url(resource_url, params))
      @logger.info "Resquest url #{uri.to_s}"
      req = Net::HTTP::Post.new(uri, headers = { 'serveToken' => serveToken, 'apiKey' => @api_key })
      @logger.info "Sending headers #{headers}"
      Net::HTTP.start(uri.host) do |http|
        http.request(req)
      end
    end

    def generate_passwd(password)
      encrypt(password).unpack("H2"*32).join
    end

    private

    def default_options
      {
        endpoint: ThreeSixty.configuration[:endpoint],
        version:  ThreeSixty.configuration[:version],
        logger:   ThreeSixty.configuration[:logger]
       }
    end

    def serveToken
      DateTime.now.strftime("%Y%m%d%H%M%S%L")
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
      [@endpoint, resource_url].join('/') << '?' << querystring(query_params) # Docs say to include version, but this breaks the request
    end

    def querystring(query_params)
      query_params.map { |key, value| key.to_s << '=' << URI.escape(value.to_s) }.join('&')
    end

  end
end