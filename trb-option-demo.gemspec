# frozen_string_literal: true

require_relative "lib/trailblazer/option/version"

Gem::Specification.new do |spec|
  spec.name          = "trb-option-demo"
  spec.version       = Trailblazer::Option::VERSION
  spec.authors       = ["Yogesh Khater"]
  spec.email         = ["yogeshjain999@gmail.com"]

  spec.summary       = "Callable implementations to forward arguments"
  spec.description   = "Run callables within given context and forward arguments"
  spec.homepage      = "https://github.com/yogeshjain999/trb-option-demo"
  spec.license       = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-line", "~> 0.6.5"
  spec.add_development_dependency "rake", "~> 13.0"
end
