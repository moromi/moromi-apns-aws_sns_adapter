class Moromi::Aws::Sns::Client
  def send_apns_message(arn:, message:, sandbox: true)
    send_apns(arn: arn, params: message.to_aws_sns_params, sandbox: sandbox)
  end

  def send_apns_message_to_topic(topic_arn:, message:, sandbox: true)
    send_apns_to_topic(topic_arn: topic_arn, params: message.to_aws_sns_params, sandbox: sandbox)
  end
end
