module SynapseApiClient
  class Calendar
    def self.events(id)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "calendar/#{id}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end