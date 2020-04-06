# Ruby Wrapper for the [ClientSuccess Open API](https://clientsuccessapi.docs.apiary.io/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "client_success"
```

And then execute:

    $ bundle


## Usage

In order to make requests against the ClientSuccess Open API you'll first need to use your existing credentials (username and password) to create an Access Token:

```ruby
response = ClientSuccess::AccessToken::Create(
  username: "test@example.com",
  password: "Password123"
)

puts response["access_token"]
=> "979e3ce5-5f57-486a-af03-d328f50bd356"
```

If the supplied credentials could not be authenticated a `ClientSuccess::AccessToken::InvalidCredentials` exception will be raised. Note that Access Tokens are valid for 12 hours, after which a new one must be created.

Once you have successfully created an Access Token you can initialise a connection object and make authenticated requests:

```ruby
cs = ClientSuccess::Connection.authorised(
  response["access_token"]
)

# get a list of all clients
clients = ClientSuccess::Client.list_all(connection: cs)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Publishing

This repository is set up to auto publish to https://rubygems.org/gems/client_success on merge into master.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ignitionapp/client_success.
