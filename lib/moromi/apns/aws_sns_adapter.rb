require "moromi/apns/aws_sns_adapter/version"

module Moromi
  module Apns
    module AwsSnsAdapter
      # Your code goes here...
    end
  end
end

class Moromi::Apns::Message::Base
  def to_aws_sns_params
    base = {
      aps: {
        badge: badge,
        alert: alert,
        sound: sound,
        'content-available' => content_available,
        priority: priority
      }
    }
    custom_data.merge(base)
  end
end

class Moromi::Aws::Sns::Client
  def send_apns_message(arn:, message:, sandbox: true)
    send_apns(arn: arn, params: message.to_aws_sns_params, sandbox: sandbox)
  end

  def send_apns_message_to_topic(topic_arn:, message:, sandbox: true)
    send_apns_to_topic(topic_arn: topic_arn, params: message.to_aws_sns_params, sandbox: sandbox)
  end
end
