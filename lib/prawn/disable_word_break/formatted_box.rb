# frozen_string_literal: true

require_relative 'line_wrap_without_word_break'

module Prawn
  module DisableWordBreak
    module FormattedBox
      def initialize(*)
        super
        @line_wrap = LineWrapWithoutWordBreak.new
      end
    end
  end
end
