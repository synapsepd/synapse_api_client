module SynapseApiClient
  class Statusnet
    def self.create_oauth_token(account_name)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "statusnet/#{account_name}/token.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end

    def self.create_avatar(account_name, width, height, image_type, url, original=0)
      @connection = SynapseApiClient.connect
      response = @connection.post do |req|
        req.url "statusnet/#{account_name}/photo.json"
        req.params['auth_token'] = SynapseApiClient.api_key
        req.params['width'] = width
        req.params['height'] = height
        req.params['image_type'] = image_type
        req.params['is_original'] = original
        req.params['url'] = url
      end
      response.body
    end

    def self.find_user_by_nickname(nickname)
      @connection = SynapseApiClient.connect
      response = @connection.get do |req|
        req.url "statusnet/#{nickname}.json"
        req.params['auth_token'] = SynapseApiClient.api_key
      end
      response.body
    end
  end
end