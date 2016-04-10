require 'moromi/apns/aws_sns_adapter/version'
require 'moromi/apns/aws_sns_adapter/config'
require 'moromi/apns/aws_sns_adapter/apns_extension'
require 'moromi/apns/aws_sns_adapter/aws_sns_extension'

module Moromi
  module Apns
    module AwsSnsAdapter
      def self.configure(&block)
        yield @config ||= Config.new
      end

      def self.config
        @config
      end
    end
  end
end
