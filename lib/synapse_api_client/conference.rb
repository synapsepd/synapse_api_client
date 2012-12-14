module SynapseApiClient
  class Conference
    def self.intl_numbers(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "conference/intl/numbers.json"
        req.params['id'] = account_name
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.details(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "conference/#{account_name}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.remove(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "conference/#{account_name}/remove.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.add(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "conference/#{account_name}/add.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.disable(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "conference/#{account_name}/disable.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.enable(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "conference/#{account_name}/enable.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end