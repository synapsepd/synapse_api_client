module SynapseApiClient
  class WifiPassword
    def self.get_password
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "wifi_password.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end