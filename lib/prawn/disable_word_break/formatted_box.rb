# frozen_string_literal: true

require_relative 'line_wrap'

module Prawn
  module DisableWordBreak
    module FormattedBox
      def initialize(*)
        super
        @line_wrap = DisableWordBreak::LineWrap.new
      end
    end
  end
end
