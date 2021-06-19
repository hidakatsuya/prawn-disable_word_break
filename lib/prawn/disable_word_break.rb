require 'prawn'

require_relative 'disable_word_break/version'
require_relative 'disable_word_break/disabler'
require_relative 'disable_word_break/formatted_box'

module Prawn
  module DisableWordBreak
    Config = Struct.new(:default, keyword_init: true)

    def self.config
      @config ||= Config.new(default: false)
    end
  end
end

Prawn::DisableWordBreak::Disabler.tap { |mod|
  Prawn::Document.include mod unless Prawn::Document.include?(mod)
}
Prawn::DisableWordBreak::FormattedBox.tap { |mod|
  Prawn::Text::Formatted::Box.prepend mod unless Prawn::Text::Formatted::Box.include?(mod)
}
