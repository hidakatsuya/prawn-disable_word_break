# frozen_string_literal: true

require 'prawn'

require_relative 'disable_word_break/version'
require_relative 'disable_word_break/wrap'

Prawn::DisableWordBreak::Wrap.tap do |mod|
  Prawn::Text::Formatted::Wrap.prepend(mod) unless Prawn::Text::Formatted::Wrap.include?(mod)
end
