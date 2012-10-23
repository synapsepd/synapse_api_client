module SynapseApiClient
  class Statusnet
    def self.create_oauth_token(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "statusnet/#{account_name}/token.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end