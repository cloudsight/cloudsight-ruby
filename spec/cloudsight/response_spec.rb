require 'spec_helper'

RSpec.describe Cloudsight::Response do
  before(:each) do
    Cloudsight.api_key = 'test_api_key'
  end

  describe '#get' do
    it 'returns the proper result' do
      stub_get(
        path: '/v1/images/sample_token',
        response: fixture_file('completed_response.json')
      )

      response = described_class.get('sample_token')

      expect(response["token"]).to  eq "sample_token"
      expect(response["url"]).to    eq "http://www.example.com/your_headphones_image.jpg"
      expect(response["status"]).to eq "completed"
    end

    it 'responds correctly to a response exception error' do
      stub_get(
        path: '/v1/images/sample_token',
        response: fixture_file('error_response.json')
      )

      expect { described_class.get('sample_token') }.to raise_error Cloudsight::ResponseException
    end

    it 'responds correctly to an unexpected response' do
      stub_get(
        path: '/v1/images/sample_token',
        response: fixture_file('unexpected_response.json')
      )

      expect { described_class.get('sample_token') }.to raise_error Cloudsight::UnexpectedResponseException
    end
  end

  describe '#retrieve' do
    it 'returns the proper result' do
      stub_polling(3, 'image_request.json', 'completed_response.json', '/v1/images/sample_token')

      response = described_class.retrieve('sample_token', poll_wait: 0.01)

      expect(response["token"]).to  eq "sample_token"
      expect(response["url"]).to    eq "http://www.example.com/your_headphones_image.jpg"
      expect(response["status"]).to eq "completed"
    end

    it 'responds correctly to a response exception error' do
      stub_polling(3, 'image_request.json', 'error_response.json', '/v1/images/sample_token')

      expect { described_class.retrieve('sample_token', poll_wait: 0.01) }.to raise_error Cloudsight::ResponseException
    end

    it 'responds correctly to an unexpected response' do
      stub_polling(3, 'image_request.json', 'unexpected_response.json', '/v1/images/sample_token')

      expect { described_class.retrieve('sample_token', poll_wait: 0.01) }.to raise_error Cloudsight::UnexpectedResponseException
    end
  end
end

def stub_polling(num_retries, file_1, file_2, path)
  retries = 0
  while retries < num_retries
    stub_get(path: path, response: fixture_file(file_1))
    retries += 1
  end

  stub_get(path: path, response: fixture_file(file_2))
end
