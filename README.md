# Prawn::DisableWordBreak

[![Gem Version](https://badge.fury.io/rb/prawn-disable_word_break.svg)](https://badge.fury.io/rb/prawn-disable_word_break)
[![Test](https://github.com/hidakatsuya/prawn-disable_word_break/actions/workflows/test.yml/badge.svg)](https://github.com/hidakatsuya/prawn-disable_word_break/actions/workflows/test.yml)

Prawn::DisableWordBreak is an extension to [Prawn](https://github.com/prawnpdf/prawn) that provides an option to disable line breaking on characters such as spaces and hyphens.

![](https://raw.githubusercontent.com/hidakatsuya/prawn-disable_word_break/master/doc/comparison-of-word-breaking.png)

See [feature test](test/features/text_line_wrapping_test.rb) for details.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prawn-disable_word_break'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install prawn-disable_word_break

## Usage

```ruby
require 'prawn/disable_word_break'
```

Or, you can set it for each method such as `text_box`.

```ruby
# Disable the default setting.
Prawn::DisableWordBreak.config.default = false
```

```ruby
Prawn::Document.generate "prawn.pdf" do
  text_box "text",
    at: [0, cursor], width: 150, height: 50, disable_word_break: true

  formatted_text_box [{ text: "text" }],
    at: [0, cursor], width: 150, height: 50, disable_word_break: true

  bounding_box [0, cursor], width: 150, height: 50 do
    text "text", disable_word_break: true
  end
end
```

## Supported Versions

### Ruby

3.0, 3.1, 3.2

### Prawn

2.4

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Testing

    $ bundle exec rake test

To run the test, you need [diff-pdf](https://github.com/vslavik/diff-pdf). You can run by installing it or using a Docker container for testing.

    $ docker pull ghcr.io/hidakatsuya/ruby-with-diff-pdf:latest
    $ docker run -v $PWD:/src:cached -it ghcr.io/hidakatsuya/ruby-with-diff-pdf bash

    > src# bundle install
    > src# bundle exec rake test

### Linting

    $ bundle exec rake standard

Or fix automatically.

    $ bundle exec rake standard:fix

See https://github.com/standardrb/standard for more details.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hidakatsuya/prawn-disable_word_break. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hidakatsuya/prawn-disable_word_wrap/blob/master/CODE_OF_CONDUCT.md).


## License

(c) 2020 Katsuya HIDAKA. The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). See [LICENSE.txt](https://github.com/hidakatsuya/prawn-disable_word_break/blob/master/LICENSE.txt) for further details.

## Code of Conduct

Everyone interacting in the Prawn::DisableWordBreak project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hidakatsuya/prawn-disable_word_break/blob/master/CODE_OF_CONDUCT.md).
