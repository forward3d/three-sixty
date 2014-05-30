module ThreeSixty
  class Account

    SERVICE_URL = 'account'

    def initialize(client)
      @client = client
    end

    def client_login(username, password)
      passwd = @client.generate_passwd(password)
      @client.request(resource_url("clientLogin"), username: username, passwd: passwd)
    end

    def resource_url(service)
      [SERVICE_URL, service].join("/")
    end

  end
end