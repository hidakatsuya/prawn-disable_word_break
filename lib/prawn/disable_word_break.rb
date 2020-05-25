require 'prawn'

require_relative 'disable_word_break/version'
require_relative 'disable_word_break/disabler'
require_relative 'disable_word_break/formatted_box'

Prawn::DisableWordBreak::Disabler.tap { |mod|
  Prawn::Document.include mod unless Prawn::Document.include?(mod)
}

Prawn::DisableWordBreak::FormattedBox.tap { |mod|
  Prawn::Text::Formatted::Box.prepend mod unless Prawn::Text::Formatted::Box.include?(mod)
}
