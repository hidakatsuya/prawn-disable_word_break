require 'prawn'

require_relative 'disable_word_break/version'
require_relative 'disable_word_break/formatted_box'

Prawn::Text::Formatted::Box.prepend Prawn::DisableWordBreak::FormattedBox
