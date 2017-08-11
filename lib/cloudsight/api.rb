module Cloudsight
  class Api
    class << self
      def post(url, params, headers = {})
        headers['Authorization'] = authorization_header(:post, url, params)
        RestClient.post(url, params, headers)
      rescue RestClient::Exception => e
        e.response
      end

      def get(url, headers = {})
        headers['Authorization'] = authorization_header(:get, url)
        RestClient.get(url, headers)
      rescue RestClient::Exception => e
        e.response
      end

      def authorization_header(http_method, url, params = {})
        if Cloudsight.api_key
          "CloudSight #{Cloudsight.api_key}"
        else
          # Exclude image file when generating OAuth header
          filtered_payload = params.dup
          filtered_payload.delete('image_request[image]')

          oauth = SimpleOAuth::Header.new(http_method, url, filtered_payload, Cloudsight.oauth_options || {})
          oauth.to_s
        end
      end
    end
  end
end
