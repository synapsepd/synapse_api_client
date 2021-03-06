module SynapseApiClient
  class Calendar
    def self.all
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "calendar.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.find(id, group_by=nil)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "calendar/#{id}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
        req.params['group_by'] = group_by if group_by
      end
      response.body
    end
  end
end