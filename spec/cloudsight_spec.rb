require 'spec_helper'
require 'simple_oauth'

RSpec.describe Cloudsight do
  context 'initialization' do
    it 'should assign the proper basic attributes' do
      Cloudsight.api_key  = 'test_api_key'
      Cloudsight.base_url = 'test_base_url'

      expect(Cloudsight.api_key) .to eq 'test_api_key'
      expect(Cloudsight.base_url).to eq 'test_base_url'
    end

    it 'should configure the oauth_options correctly' do
      Cloudsight.oauth_options = {
        consumer_key: 'test_consumer_key',
        consumer_secret: 'test_consumer_secret'
      }

      expect(Cloudsight.oauth_options[:consumer_key]).to    eq 'test_consumer_key'
      expect(Cloudsight.oauth_options[:consumer_secret]).to eq 'test_consumer_secret'
    end
  end
end
