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

class Moromi::Apns::Environment::Base
  def aws_sns_application_arn
    @aws_sns_application_arn ||= Moromi::Apns::AwsSnsAdapter.config.aws_sns_application_arns[key]
  end
end
