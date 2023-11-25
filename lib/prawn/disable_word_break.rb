# frozen_string_literal: true

require 'prawn'
require 'forwardable'

require_relative 'disable_word_break/version'
require_relative 'disable_word_break/wrap'

module Prawn
  module DisableWordBreak
    extend Forwardable

    Config = Struct.new(
      # Sets the default value for the disable_word_break option. Default is true.
      :default,

      keyword_init: true
    )

    def self.config
      @config ||= Config.new(default: true)
    end
  end
end

Prawn::DisableWordBreak::Wrap.tap do |mod|
  Prawn::Text::Formatted::Wrap.prepend(mod) unless Prawn::Text::Formatted::Wrap.include?(mod)
end
