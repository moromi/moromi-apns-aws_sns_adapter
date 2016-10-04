# Moromi::Apns::AwsSnsAdapter

[![Latest Version](https://img.shields.io/gem/v/moromi-apns-aws_sns_adapter.svg)](http://rubygems.org/gems/moromi-apns-aws_sns_adapter)

extension for moromi-apns and moromi-aws-sns

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'moromi-apns-aws_sns_adapter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install moromi-apns-aws_sns_adapter

## Usage

- config/initializers/moromi/apns.rb

```ruby
Moromi::Apns.configure do |config|
  config.identifiers = {
    production: 'com.example.moromi.apns.production',
    in_house: 'com.example.moromi.apns.inhouse',
    debug: 'com.example.moromi.apns.debug'
  }
end

Moromi::Apns::AwsSnsAdapter.configure do |config|
  config.aws_sns_application_arns = {
    production: 'arn:aws:sns:ap-northeast-1:000000000000:app/APNS/moromi-apns-production',
    in_house: 'arn:aws:sns:ap-northeast-1:000000000000:app/APNS/moromi-apns-in_house',
    debug: 'arn:aws:sns:ap-northeast-1:000000000000:app/APNS_SANDBOX/moromi-apns-debug'
  }
end
```

- config/initializers/moromi/aws_sns.rb

```ruby
module Moromi
  module Aws
    module Sns
      class Client
        # @param [Moromi::Apns::Environment::Base]
        def self.create(environment)
          new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_ACCESS_KEY'], ENV['AWS_REGION'], environment.aws_sns_application_arn)
        end
      end
    end
  end
end
```

### Register device

```ruby
environment = Moromi::Apns.environment('com.example.moromi.apns.production')
arn = Moromi::Aws::Sns::Client.create(environment).register(token: token)
# store arn
```

### Send APNS

```ruby
environment = Moromi::Apns.environment('com.example.moromi.apns.production')
message = Moromi::Apns::Message::Announce.make(message: 'Message')

client = Moromi::Aws::Sns::Client.create(environment)
client.send_apns_message(arn: arn, message: message, sandbox: environment.sandbox?)
```

- use ActiveJob

```
class AmazonSnsJob < ApplicationJob
  queue_as :amazon_sns

  def perform(hash)
    params = hash.with_indifferent_access

    bundle_identifier = params[:bundle_identifier]
    arn = params[:arn]

    message = Moromi::Apns::Message::Builder.build(params[:data])
    raise unless message.is_a? Moromi::Apns::Message::Base

    environment = Moromi::Apns.environment(bundle_identifier)

    client = Moromi::Aws::Sns::Client.create(environment)
    client.send_apns_message(arn: arn, message: message, sandbox: environment.sandbox?)
  rescue Moromi::Apns::Environment::InvalidEnvironment => e
    Rails.logger.error e.message
  rescue Aws::SNS::Errors::EndpointDisabled => e
    Rails.logger.info e.message
  end

  # @param [Moromi::Apns::Message::Base] message
  # @param [String] bundle_identifier
  # @param [String] arn
  def self.enqueue_job(bundle_identifier, arn, message)
    params = {
      bundle_identifier: bundle_identifier,
      arn: arn,
      data: message.serialize
    }
    perform_later(params)
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moromi/moromi-apns-aws_sns_adapter.

