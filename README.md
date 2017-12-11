cloudsight-ruby
===============

A simple CloudSight API Client

| Project                 |  Gem Release      |
|------------------------ | ----------------- |
| gem name                |  cloudsight       |
| version                 |  [![Gem Version](https://badge.fury.io/rb/cloudsight.svg)](https://badge.fury.io/rb/cloudsight)
| continuous integration  |  [![Build Status](https://secure.travis-ci.org/cloudsight/cloudsight-ruby.png?branch=master)](https://travis-ci.org/cloudsight/cloudsight-ruby) |

Installation
============

```
$ gem install cloudsight
```

Install the `simple_oauth` gem to use with oauth options.

```
$ gem install simple_oauth
```

Configuration
=============

```ruby
require 'rubygems'
require 'simple_oauth'
require 'cloudsight'

Cloudsight.oauth_options = {
  consumer_key: 'REPLACE WITH YOUR KEY',
  consumer_secret: 'REPLACE WITH YOUR SECRET'
}
```

or, using a single API key:

```ruby
require 'rubygems'
require 'cloudsight'

Cloudsight.api_key = 'REPLACE WITH YOUR KEY'
```

Usage
=====

Send the image request using a file:

```ruby
request_data = Cloudsight::Request.send(locale: 'en', file: File.open('image.jpg'))
```

Or, you can send the image request using a URL:

```ruby
request_data = Cloudsight::Request.send(locale: 'en', url: 'http://www.google.com/images/srpr/logo11w.png')
```

Then, use the token to retrieve the response:

```ruby
response_data = Cloudsight::Response.get(request_data['token'])
```

You can also use the `retrieve` method which will poll for the response for you:

```ruby
Cloudsight::Response.retrieve(request_data['token']) do |response_data|
  p response_data
end
```
