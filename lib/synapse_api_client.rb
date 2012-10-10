require "synapse_api_client/version"

module SynapseApiClient
  autoload :WifiPassword, 'synapse_api_client/wifi_password'
  autoload :User, 'synapse_api_client/user'

  # The exception class from which all Recurly exceptions inherit.
  class Error < StandardError
    def set_message message
      @message = message
    end

    # @return [String]
    def to_s
      defined? @message and @message or super
    end
  end

  # This exception is raised if Recurly has not been configured.
  class ConfigurationError < Error
  end

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
         cache_dir = File.join(ENV['TMPDIR'] || '/tmp', 'cache')
         conn.response :caching, :ignore_params => %w[auth_token] do
           ActiveSupport::Cache::FileStore.new cache_dir, :namespace => 'synapse', :expires_in => 216000  # one hour
         end
       end
    end
    attr_writer :connection

    def api_key
      defined? @api_key and @api_key or raise(
        ConfigurationError, "SynapseApiClient.api_key not configured"
      )
    end

    attr_writer :api_key

  end
end
