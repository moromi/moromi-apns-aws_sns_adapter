require 'active_support/configurable'

module Moromi
  module Apns
    module AwsSnsAdapter
      class Config
        include ActiveSupport::Configurable

        config_accessor :aws_sns_application_arns
        config_accessor :application_arn_builder_class
      end
    end
  end
end
