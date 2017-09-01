# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moromi/apns/aws_sns_adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "moromi-apns-aws_sns_adapter"
  spec.version       = Moromi::Apns::AwsSnsAdapter::VERSION
  spec.authors       = ["Takahiro Ooishi"]
  spec.email         = ["taka0125@gmail.com"]

  spec.summary       = %q{adapter for moromi-apns, moromi-aws-sns}
  spec.description   = %q{adapter for moromi-apns, moromi-aws-sns}
  spec.homepage      = "https://github.com/moromi/moromi-apns-aws_sns_adapter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', ['>= 4.2']
  spec.add_dependency 'moromi-apns', '< 1.0'
  spec.add_dependency 'moromi-aws-sns', '< 1.0', '~> 0.5'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
