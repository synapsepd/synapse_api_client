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

    def self.search(query=nil)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.params['auth_token'] = SynapseApiClient.api_key
        if query
          req.url "users/search.json"
          req.params['q'] = query
        else
          req.url "users.json"
        end
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

    def filter_by(field_names = [])
      field_names.each do |f|
        @users = @users.find_all { |u| u.field_name == params[field_name.to_sym]}
      end
      @users
    end

    def sort_by(field_name, order)
      if field_name
        if field_name == 'name'
          @users = @users.sort! { |a, b| a.last_name <=> b.last_name }
        elsif field_name == 'start_date'
          @users = @users.sort! { |a, b| a.start_date <=> b.start_date }
        elsif field_name == 'department'
          @users = @users.sort! { |a, b| a.department <=> b.department }
        end

        if order == 'desc'
          @users.reverse
        end
      end
    end
  end
end