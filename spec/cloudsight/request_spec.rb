require 'spec_helper'

RSpec.describe Cloudsight::Request do

  before(:each) do
    Cloudsight.api_key = 'test_api_key'
  end

  describe '#construct_params' do
    let(:params) do
      {
        locale: 'en',
        language: 'en',
        latitude: '5',
        longitude: '5',
        altitude: '5',
        device_id: '5',
        ttl: '5',
        url: 'test_url',
        file: 'test_file',
        focus: {
          x: '5',
          y: '5'
        }
      }
    end

    it 'correctly constructs the params' do
      options = described_class.construct_params(params)
      expect(options).to eq(
        {
          'image_request[locale]' => 'en',
          'image_request[language]' => 'en',
          'image_request[latitude]' => '5',
          'image_request[longitude]' => '5',
          'image_request[altitude]' => '5',
          'image_request[device_id]' => '5',
          'image_request[ttl]' => '5',
          'image_request[remote_image_url]' => 'test_url',
          'image_request[image]' => 'test_file',
          'focus[x]' => '5',
          'focus[y]' => '5'
        }
      )
    end
  end

  describe '#send' do
    let(:params) { { locale: 'en', url: 'test_url' } }

    it 'returns the proper result' do
      stub_post(
        path: '/image_requests',
        body: { "image_request"=>{ "locale"=>"en", "remote_image_url"=>"test_url" } },
        response: fixture_file('image_request.json')
      )

      response = described_class.send(params) 

      expect(response["token"]).to  eq "sample_token"
      expect(response["url"]).to    eq "https://example.com/image.jpg"
      expect(response["status"]).to eq "not completed"
    end

    it 'responds correctly to a response exception error' do
      stub_post(
        path: '/image_requests',
        body: { "image_request"=>{ "locale"=>"en", "remote_image_url"=>"test_url" } },
        response: fixture_file('error_response.json')
      )

      expect { described_class.send(params) }.to raise_error Cloudsight::ResponseException
    end

    it 'responds correctly to an unexpected response' do
      stub_post(
        path: '/image_requests',
        body: { "image_request"=>{ "locale"=>"en", "remote_image_url"=>"test_url" } },
        response: fixture_file('unexpected_response.json')
      )

      expect { described_class.send(params) }.to raise_error Cloudsight::UnexpectedResponseException
    end
  end

  describe '#repost' do
    let(:params) { { image_request: { locale: 'en', remote_image_url: 'test_url' } } }

    it 'returns the proper result' do
      stub_post(
        path: '/image_requests/sample_token/repost',
        body: { "image_request"=>{ "locale"=>"en", "remote_image_url"=>"test_url" } },
        response: fixture_file('image_request.json')
      )

      response = described_class.repost('sample_token', params)

      expect(response["token"]).to  eq "sample_token"
      expect(response["url"]).to    eq "https://example.com/image.jpg"
      expect(response["status"]).to eq "not completed"
    end

    it 'responds correctly to a response exception error' do
      stub_post(
        path: '/image_requests/sample_token/repost',
        body: { "image_request"=>{ "locale"=>"en", "remote_image_url"=>"test_url" } },
        response: fixture_file('error_response.json')
      )

      expect { described_class.repost('sample_token', params) }.to raise_error Cloudsight::ResponseException
    end

    it 'responds correctly to an unexpected response' do
      stub_post(
        path: '/image_requests/sample_token/repost',
        body: { "image_request"=>{ "locale"=>"en", "remote_image_url"=>"test_url" } },
        response: fixture_file('unexpected_response.json')
      )

      expect { described_class.repost('sample_token', params) }.to raise_error Cloudsight::UnexpectedResponseException
    end
  end
end
