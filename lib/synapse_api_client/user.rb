module SynapseApiClient
  class User
    def self.find_by_account_name(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "users/#{account_name}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.is_member_of_group(account_name, group_dn)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "users/#{account_name}/group/#{URI.escape(group_dn)}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.all
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "users.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end