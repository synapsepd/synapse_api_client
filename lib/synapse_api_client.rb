require "synapse_api_client/version"
require "faraday"
require "faraday_middleware"
require "hashie"

module SynapseApiClient
  autoload :WifiPassword, 'synapse_api_client/wifi_password'
  autoload :User, 'synapse_api_client/user'
  autoload :Statusnet, 'synapse_api_client/statusnet'
  autoload :Calendar, 'synapse_api_client/calendar'
  autoload :Location, 'synapse_api_client/location'
  autoload :Conference, 'synapse_api_client/conference'

  # The exception class from which all exceptions inherit.
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
      @connection = Faraday.new(:url => @api_url, :ssl => { :verify => false}) do |conn|
         conn.request  :url_encoded
         conn.response :mashify
         conn.response :json
         conn.response :logger unless Rails.env.production?
         conn.response :raise_error
         conn.use :instrumentation
         if @caching
           cache_dir = File.join(ENV['TMPDIR'] || '/tmp', 'cache')
           conn.response :caching, :ignore_params => %w[auth_token] do
             ActiveSupport::Cache::FileStore.new cache_dir, :namespace => 'synapse', :expires_in => 1800  # one hour
           end
         end
         conn.adapter Faraday.default_adapter

       end
    end
    attr_writer :connection

    def api_key
      defined? @api_key and @api_key or raise(
        ConfigurationError, "SynapseApiClient.api_key not configured"
      )
    end

    def api_url
      defined? @api_url and @api_url or raise(
        ConfigurationError, "SynapseApiClient.api_url not configured"
      )
    end

    def caching
      defined? @caching and @caching or @caching = false
    end

    attr_writer :api_key
    attr_writer :api_url
    attr_writer :caching

  end
end
