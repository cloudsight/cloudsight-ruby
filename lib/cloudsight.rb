require 'rubygems'
require 'rest-client'
begin
  require 'simple_oauth'
rescue LoadError
  # Tolerate not having this unless it's actually configured
end
require 'json'

module Cloudsight
  BASE_URL = 'https://api.cloudsight.ai'

  class << self
    FIELDS = %w(api_key oauth_options base_url)
    attr_accessor(*FIELDS)

    def oauth_options=(val)
      raise RuntimeError.new(
        "Could not load the simple_oauth gem. Install it with `gem install simple_oauth`."
      ) unless defined?(SimpleOAuth::Header)

      val = val.inject({}) {|memo, (k, v)| memo[k.to_sym] = v; memo }
      @oauth_options = val
    end

    def base_url
      @base_url ||= BASE_URL
    end
  end

  require_relative './cloudsight/api'
  require_relative './cloudsight/request'
  require_relative './cloudsight/response'

  class ResponseException < Exception; end
  class UnexpectedResponseException < Exception; end
end
