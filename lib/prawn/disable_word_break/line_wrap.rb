# frozen_string_literal: true

module Prawn
  module DisableWordBreak
    class LineWrap < Text::Formatted::LineWrap
      private

      # Override
      def add_fragment_to_line(fragment)
        return super(fragment) if fragment == '' || fragment == "\n"

        insert_fragment_without_word_break(fragment)
      end

      def insert_fragment_without_word_break(fragment)
        fragment = delete_invisible_chars(fragment)
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

      def delete_invisible_chars(fragment)
        encoding = fragment.encoding

        invisible_chars = [
          soft_hyphen(encoding),
          zero_width_space(encoding)
        ].join
        fragment.delete(invisible_chars)
      end
    end
  end
end
