require_relative 'lib/prawn/disable_word_break/version'

Gem::Specification.new do |spec|
  spec.name          = 'prawn-disable_word_break'
  spec.version       = Prawn::DisableWordBreak::VERSION
  spec.authors       = ['Katsuya Hidaka']
  spec.email         = ['hidakatsuya@gmail.com']

  spec.summary       = 'Disables word-breaking by character such as space and hyphen to Prawn'
  spec.description   = 'Prawn::DisableWordBreak is an extension that disables word-breaking by character such as space and hyphen to Prawn'
  spec.homepage      = 'https://github.com/hidakatsuya/prawn-disable_word_break'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.0')

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^test/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'prawn', '~> 2.2'
end
