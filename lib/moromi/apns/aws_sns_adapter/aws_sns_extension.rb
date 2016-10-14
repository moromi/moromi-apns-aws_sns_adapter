class Moromi::Aws::Sns::Client
  def send_apns_message(arn, message)
    send_apns(arn, message.to_aws_sns_params)
  end

  def send_apns_message_to_topic(topic_arn, message)
    send_apns_to_topic(topic_arn, message.to_aws_sns_params)
  end
end
