# frozen_string_literal: true

module Prawn
  module DisableWordBreak
    module Disabler
      def word_break(disable, &block)
        if disable
          disable_word_break(&block)
        else
          block.call
        end
      end

      def disable_word_break
        @word_break_disabled = true
        yield
      ensure
        @word_break_disabled = false
      end

      def word_break_disabled?
        defined?(@word_break_disabled) ? @word_break_disabled : DisableWordBreak.config.default
      end
    end
  end
end
