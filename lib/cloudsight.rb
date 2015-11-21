require 'rubygems'
require 'rest-client'
begin
	require 'simple_oauth'
rescue LoadError => err
	# Tolerate not having this unless it's actually configured
end
require 'json'

module Cloudsight
	BASE_URL = 'https://api.cloudsightapi.com'

	class << self
		def oauth_options=(val)
			raise RuntimeError.new("Could not load the simple_oauth gem. Install it with `gem install simple_oauth`.") unless defined?(SimpleOAuth::Header)

			val = val.inject({}) {|memo, (k, v)| memo[k.to_sym] = v; memo }
			@@oauth_options = val
		end

		def api_key=(val)
			@@api_key = val
			RestClient.add_before_execution_proc do |req, params|
				req.add_field 'Authorization', "CloudSight #{val}"
			end
		end

		def api_key
			@@api_key if defined?(@@api_key)
		end

		def oauth_options
			@@oauth_options if defined?(@@oauth_options)
		end

		def base_url=(val)
			@@base_url = val
		end

		def base_url
			@@base_url ||= BASE_URL
		end
	end

	class Util
		def self.wrap_request &block
			RestClient.reset_before_execution_procs
			RestClient.add_before_execution_proc do |req, params|
				if params[:payload]
					filtered_payload = params[:payload].dup
					filtered_payload.delete('image_request[image]')
				end

				oauth = SimpleOAuth::Header.new(params[:method], params[:url], filtered_payload, Cloudsight.oauth_options || {})
			  req.add_field 'Authorization', oauth.to_s
			end

			begin
				retval = yield
			rescue RestClient::Exception => e
				retval = e.response
			end

			RestClient.reset_before_execution_procs

			return retval
		end
	end

	class Request
		def self.send(options = {})
			raise RuntimeError.new("Need to define either oauth_options or api_key") unless Cloudsight.api_key || Cloudsight.oauth_options
			url = "#{Cloudsight::base_url}/image_requests"

			params = {}
			[:locale, :language, :latitude, :longitude, :altitude, :device_id, :ttl].each do |attr|
				params["image_request[#{attr}]"] = options[attr] if options.has_key?(attr)
			end

			if options[:focus]
				params['focus[x]'] = options[:focus][:x]
				params['focus[y]'] = options[:focus][:y]
			end

			params['image_request[remote_image_url]'] = options[:url] if options.has_key?(:url)
			params['image_request[image]'] = options[:file] if options.has_key?(:file)

			response = Util.wrap_request { RestClient.post(url, params) }
			data = JSON.parse(response.body)
			raise ResponseException.new(data['error']) if data['error']
			raise UnexpectedResponseException.new(response.body) unless data['token']
			
			data
		end
	end

	class Response
		def self.get(token, options = {})
			url = "#{Cloudsight::base_url}/image_responses/#{token}"

			response = Util.wrap_request { RestClient.get(url) }
			data = JSON.parse(response.body)
			raise ResponseException.new(data['error']) if data['error']
			raise UnexpectedResponseException.new(response.body) unless data['status']

			data
		end

		def self.retrieve(token, options = {})
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

	class ResponseException < Exception; end
	class UnexpectedResponseException < Exception; end
end
