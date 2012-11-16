module SynapseApiClient
  class Location
    def self.all
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "locations.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.find(id)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "locations/#{id}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end