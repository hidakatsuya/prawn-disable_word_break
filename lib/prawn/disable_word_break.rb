# frozen_string_literal: true

require 'prawn'

require_relative 'disable_word_break/version'
require_relative 'disable_word_break/wrap'

Prawn::Text::Box.extensions << Prawn::DisableWordBreak::Wrap
Prawn::Text::Formatted::Box.extensions << Prawn::DisableWordBreak::Wrap
