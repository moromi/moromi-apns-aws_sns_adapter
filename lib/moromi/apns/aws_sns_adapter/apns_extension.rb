class Moromi::Apns::Message::Base
  include Moromi::Aws::Sns::Message::Base

  def to_parameter
    base = {
      aps: {
        badge: badge,
        alert: alert,
        sound: sound,
        'content-available' => content_available,
        'mutable-content' => mutable_content,
        priority: priority
      }
    }
    Moromi::Aws::Sns::Message::Parameter.new(apns: custom_data.merge(base))
  end
end

class Moromi::Apns::Environment::Base
  def aws_sns_application_arn
    @aws_sns_application_arn ||= Moromi::Apns::AwsSnsAdapter.config.aws_sns_application_arns[key]
  end
end
