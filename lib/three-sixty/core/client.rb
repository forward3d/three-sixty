module ThreeSixty
  module Core
    module Client

      def client_request(client, url, params = {})
        response =  client.request(url, params)
        raise ThreeSixtyResponseError.new("Invalid request: #{response['failures']}") if response.is_a?(Hash) && ! response['failures'].nil?
        response
      end

      class ThreeSixtyResponseError < StandardError; end

    end
  end
end
