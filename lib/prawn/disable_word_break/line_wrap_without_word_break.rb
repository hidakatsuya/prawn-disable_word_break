# frozen_string_literal: true

module Prawn
  module DisableWordBreak
    class LineWrapWithoutWordBreak < Text::Formatted::LineWrap
      # Override Prawn::Text::Formatted::LineWrap#add_fragment_to_line
      def add_fragment_to_line(fragment)
        if fragment == ''
          true
        elsif fragment == "\n"
          @newline_encountered = true
          false
        else
          fragment_width = @document.width_of(fragment, kerning: @kerning)

          if @accumulated_width + fragment_width <= @width
            @accumulated_width += fragment_width
            @fragment_output += fragment
            fragment_finished(fragment)
            true
          else
            end_of_the_line_reached(fragment)
            fragment_finished(fragment)
            false
          end
        end
      end
    end
  end
end
