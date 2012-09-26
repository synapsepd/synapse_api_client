module SynapseApiClient
  class WifiPassword
    def self.get_password
      @connection = SynapseApiClient.connect
      response = @conn.get do |req|
        req.url "wifi_password.json"
      end
      response.body
    end
  end
end