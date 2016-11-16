# SingleUserOauth
Before you make a request to Twitter's Streaming API, you have to get authenticated using OAuth.
This <code>ruby gem</code> will help you to generate unique <code> OAuth Header Token</code>, which is required to make a request to Twitter streaming API's. 

* https://dev.twitter.com/streaming/public has very good documentation on making calls to twitter API's. 
* This gem implements <code> Single User Oauth </code> type of OAuth authentication.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'single_user_oauth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install single_user_oauth

## Usage

#### Generating OAuth Header.
`oauth_header = SingleUserOauth.generate_header(oauth_params)`

#### Params to Send For OAuth Generation.
```
def oauth_params
    {
      request_method: 'GET',
      requested_url: 'https://sitestream.twitter.com/1.1/site.json',
      query_params: {
        follow: '6253282'
      },
      oauth_consumer_key: 'xyz',
      oauth_token: '123',
      oauth_consumer_secret: 'abc',
      oauth_access_secret: 'def'
    }
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/single_user_oauth. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

