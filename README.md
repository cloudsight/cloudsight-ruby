cloudsight-ruby
===============

A simple CloudSight API Client

Configuration
=============

```ruby
require 'rubygems'
require 'cloudsight'

CamFind.oauth_options = {
  consumer_key: 'REPLACE WITH YOUR KEY',
  consumer_secret: 'REPLACE WITH YOUR SECRET'
}
```

Usage
=====

Send the image request using a file:

```ruby
requestData = CamFind::Request.send(locale: 'en', file: File.open('image.jpg'))
```

Or, you can send the image request using a URL:

```ruby
requestData = CamFind::Request.send(locale: 'en', url: 'http://www.google.com/images/srpr/logo11w.png')
```

Then, use the token to retrieve the response:

```ruby
responseData = CamFind::Response.get(requestData['token'])
```

You can also use the `retrieve` method which will poll for the response for you:

```ruby
CamFind::Response.retrieve(requestData['token']) do |responseData|
  p responseData
end
```
