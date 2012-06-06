require "synapse_api_client/version"

module SynapseApiClient
  class User
    def self.find_by_account_name(account_name)
      @conn = self.connect
      response = @conn.get do |req|
        req.url "users/#{account_name}.json"
      end
      response.body
    end

    def self.is_member_of_group(account_name, group_dn)
      @conn = self.connect
      response = @conn.get do |req|
        req.url "users/#{account_name}/group/#{URI.escape(group_dn)}.json"
      end
      response.body
    end
    
    private
    
    def self.connect
      connection = Faraday.new(:url => Settings.synapse_api_url, ssl: {verify: false}) do |conn|
         conn.request  :url_encoded
         conn.response :mashify
         conn.response :json
         conn.response :logger
         conn.response :raise_error
         conn.use :instrumentation

         conn.adapter :net_http
         conn.headers[:user_agent] = 'MyLib v1.2'
       end
    end   
  end
end
