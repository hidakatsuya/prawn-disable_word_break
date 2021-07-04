# frozen_string_literal: true

require_relative 'line_wrap'

module Prawn
  module DisableWordBreak
    module Wrap
      # override
      def wrap(*)
        @line_wrap = DisableWordBreak::LineWrap.new
        super
      end
    end
  end
end
