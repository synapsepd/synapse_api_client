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

    def self.search(params={}, field_names=[])
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.params['auth_token'] = SynapseApiClient.api_key
        if params['q']
          req.url "users/search.json"
          req.params['q'] = params['q']
        else
          req.url "users.json"
        end
      end
      users = response.body
      users = SynapseApiClient::User.filter_by(users, field_names, params)
      users = SynapseApiClient::User.sort_by(users, params[:sort_by], params[:order] ? params[:order] : 'desc')
    end

    def self.update_attribute(account_name, value)
      @connection = SynapseApiClient.connect
      response = @connection.put "users/#{account_name}" do |req|
        req.params['auth_token'] = SynapseApiClient.api_key
        req.params['value'] = value
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

    private

    def self.filter_by(users, field_names = [], params = {})
      if field_names
        field_names.each do |f|
          if params[f.to_sym]
            users = users.find_all { |u| u[f].downcase == params[f.to_sym].downcase }
          end
        end
      end
      users
    end

    def self.sort_by(users, field_name, order)
      if field_name
        if order == 'desc'
          users = users.sort! { |a, b| a[field_name] <=> b[field_name] }.reverse
        else
          users = users.sort! { |a, b| a[field_name] <=> b[field_name] }
        end
      else
        users
      end
    end
  end
end