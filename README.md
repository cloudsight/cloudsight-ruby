cloudsight-ruby
===============

A simple CloudSight API Client

| Project                 |  Gem Release      |
|------------------------ | ----------------- |
| gem name                |  gem-release      |
| license                 |  [MIT][license]   |
| version                 |  [![Gem Version](https://badge.fury.io/rb/gem-release.png)](http://badge.fury.io/rb/gem-release) |
| continuous integration  |  [![Build Status](https://secure.travis-ci.org/cloudsight/cloudsight-ruby.png?branch=master)](https://travis-ci.org/cloudsight/cloudsight-ruby) |

Installation
============

```
$ gem install cloudsight
```

Configuration
=============

```ruby
require 'rubygems'
require 'cloudsight'

Cloudsight.oauth_options = {
  consumer_key: 'REPLACE WITH YOUR KEY',
  consumer_secret: 'REPLACE WITH YOUR SECRET'
}
```

Usage
=====

Send the image request using a file:

```ruby
requestData = Cloudsight::Request.send(locale: 'en', file: File.open('image.jpg'))
```

Or, you can send the image request using a URL:

```ruby
requestData = Cloudsight::Request.send(locale: 'en', url: 'http://www.google.com/images/srpr/logo11w.png')
```

Then, use the token to retrieve the response:

```ruby
responseData = Cloudsight::Response.get(requestData['token'])
```

You can also use the `retrieve` method which will poll for the response for you:

```ruby
Cloudsight::Response.retrieve(requestData['token']) do |responseData|
  p responseData
end
```
