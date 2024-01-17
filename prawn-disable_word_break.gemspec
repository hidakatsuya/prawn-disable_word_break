require_relative "lib/prawn/disable_word_break/version"

Gem::Specification.new do |spec|
  spec.name = "prawn-disable_word_break"
  spec.version = Prawn::DisableWordBreak::VERSION
  spec.authors = ["Katsuya Hidaka"]
  spec.email = ["hidakatsuya@gmail.com"]

  spec.summary = "A Prawn extension that provides an option to disable line breaks for characters such as spaces and hyphens."
  spec.description = "Prawn::DisableWordBreak is a Prawn extension that provides an option to disable line breaks for characters such as spaces and hyphens."
  spec.homepage = "https://github.com/hidakatsuya/prawn-disable_word_break"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "prawn", ">= 2.4.0"
  spec.add_dependency "matrix", "~> 0.4"

  spec.add_development_dependency "rake", ">= 0"
  spec.add_development_dependency "test-unit", ">= 3.3.5"
  spec.add_development_dependency "test-unit-rr", ">= 1.0.5"
  spec.add_development_dependency "pdf_matcher-testing", ">= 1.0.0"
  spec.add_development_dependency "standard", ">= 1.31.0"
end
