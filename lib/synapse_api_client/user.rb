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

    def self.search(query)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "users/search.json"
        req.params['auth_token'] = SynapseApiClient.api_key
        req.params['q'] = query
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

    def where(field_name, value)
      @users = @users.find_all { |person| person.field_name == params[:value] }
    end
  end
end