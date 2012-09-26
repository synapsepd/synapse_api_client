require "synapse_api_client/version"

module SynapseApiClient
  autoload :WifiPassword, 'synapse_api_client/wifi_password'
  autoload :User, 'synapse_api_client/user'

  class << self

    def connect
      @connection = Faraday.new(:url => 'https://api-dev.synapse.com/v1/', :ssl => { :verify => false}) do |conn|
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
    attr_writer :connection

    def api_key
      defined? @api_key and @api_key or raise(
        ConfigurationError, "Recurly.api_key not configured"
      )
    end

    attr_writer :api_key

  end
end
