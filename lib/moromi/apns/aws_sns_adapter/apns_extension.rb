class Moromi::Apns::Message::Base
  include Moromi::Aws::Sns::Message::Base

  def to_parameter
    Moromi::Aws::Sns::Message::Parameter.new(apns: to_hash)
  end
end

class Moromi::Apns::Environment::Base
  def aws_sns_application_arn
    @aws_sns_application_arn ||= Moromi::Apns::AwsSnsAdapter.config.aws_sns_application_arns[key]
  end
end
