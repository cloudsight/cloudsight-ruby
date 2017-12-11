module Cloudsight
  class Response
    class << self
      def get(token, options = {})
        url = "#{Cloudsight::base_url}/v1/images/#{token}"

        response = Api.get(url)
        data = JSON.parse(response.body)
        raise ResponseException.new(data['error']) if data['error']
        raise UnexpectedResponseException.new(response.body) unless data['status']

        data
      end

      def retrieve(token, options = {})
        options = { poll_wait: 1 }.merge(options)

        data = nil
        loop do
          sleep options[:poll_wait]
          data = Cloudsight::Response.get(token, options)
          yield data if block_given?
          break if data['status'] != 'not completed' and data['status'] != 'in progress'
        end

        data
      end
    end
  end
end
