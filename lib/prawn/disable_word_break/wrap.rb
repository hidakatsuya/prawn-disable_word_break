# frozen_string_literal: true

require_relative "line_break_anywhere"

module Prawn
  module DisableWordBreak
    module Wrap
      # override
      def initialize(_, options)
        super

        @line_wrap = LineBreakAnywhere.new if DisableWordBreak.config.default || options[:disable_word_break]
      end

      # override
      def valid_options
        super + %i[disable_word_break]
      end
    end
  end
end
