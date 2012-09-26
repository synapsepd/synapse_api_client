module SynapseApiClient
  class User
    def self.find_by_account_name(account_name)
      @connection = self.connect
      response = @conn.get do |req|
        req.url "users/#{account_name}.json"
      end
      response.body
    end

    def self.is_member_of_group(account_name, group_dn)
      @connection = self.connect
      response = @conn.get do |req|
        req.url "users/#{account_name}/group/#{URI.escape(group_dn)}.json"
      end
      response.body
    end
  end
end