require 'bundler/setup'
require 'cloudsight'
require 'webmock/rspec'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after(:each) do
    Cloudsight.api_key       = nil
    Cloudsight.oauth_options = {}
    Cloudsight.base_url      = nil
  end

end

def stub_get(path:, response:, status: 200, message: nil)
  stub_request(:get, Cloudsight::BASE_URL + path).to_return(
    status: status,
    body: response,
    exception: message
  )
end

def stub_post(path:, body: {}, response: {}, status: 200, message: nil)
  stub_request(:post, Cloudsight::BASE_URL + path).with(
    body: hash_including(body)
  ).to_return(
    status: status,
    body: response,
    exception: message
  )
end

def fixture_file(filename, options={})
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  fixture   = File.read(file_path)

  case File.extname(file_path)
  when '.json'
    options[:parse] ? JSON.parse(fixture) : fixture
  else
    fixture
  end
end

