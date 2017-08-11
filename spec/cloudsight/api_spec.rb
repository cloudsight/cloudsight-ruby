require 'spec_helper'
require 'simple_oauth'

RSpec.describe Cloudsight::Api do

  describe '#authorization_header' do
    context 'with an api_key' do
      it 'returns the proper header' do
        Cloudsight.api_key = 'test_api_key'
        header = described_class.authorization_header(:get, 'test')
        expect(header).to eq 'CloudSight test_api_key'
      end
    end

    context 'with simple oauth' do
      it 'returns the proper header' do
        Cloudsight.oauth_options = {
          consumer_key: 'test_consumer_key',
          consumer_secret: 'test_consumer_secret'
        }

        header = described_class.authorization_header(:get, 'https://example.com', { image_request: {} })
        expect(header).to match(/OAuth oauth_consumer_key=/)
      end
    end
  end

  describe '#post' do
    let(:url) { 'https://example.com' }

    it 'should post with the correct params' do
      allow(described_class).to receive(:authorization_header).and_return("CloudSight test_api_key")

      expect(RestClient).to receive(:post).with(
        url, {}, {"Authorization"=>"CloudSight test_api_key"}
      )

      described_class.post(url, {})
    end

    it 'should return the response if there is one' do
      allow(described_class).to receive(:authorization_header).and_return("CloudSight test_api_key")

      allow(RestClient).to receive(:post).with(
        url, {}, {"Authorization"=>"CloudSight test_api_key"}
      ).and_raise(RestClient::Exception)

      expect { described_class.post(url, {}) }.to_not raise_error
    end
  end

  describe '#get' do
    let(:url) { 'https://example.com' }

    it 'should post with the correct params' do
      allow(described_class).to receive(:authorization_header).and_return("CloudSight test_api_key")

      expect(RestClient).to receive(:get).with(
        url, {"Authorization"=>"CloudSight test_api_key"}
      )

      described_class.get(url, {})
    end

    it 'should return the response if there is one' do
      allow(described_class).to receive(:authorization_header).and_return("CloudSight test_api_key")

      allow(RestClient).to receive(:get).with(
        url, {"Authorization"=>"CloudSight test_api_key"}
      ).and_raise(RestClient::Exception)

      expect { described_class.get(url, {}) }.to_not raise_error
    end
  end
end
