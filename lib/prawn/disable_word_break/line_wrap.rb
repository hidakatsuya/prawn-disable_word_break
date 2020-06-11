# frozen_string_literal: true

module Prawn
  module DisableWordBreak
    class LineWrap < Text::Formatted::LineWrap
      private

      attr_reader :word_break_disabled

      # Override
      def initialize_line(options)
        super
        @word_break_disabled = @document.word_break_disabled?
      end

      # Override
      def add_fragment_to_line(fragment)
        if fragment == ''
          true
        elsif fragment == "\n"
          @newline_encountered = true
          false
        else
          if word_break_disabled
            insert_fragment_without_word_break(fragment)
          else
            insert_fragment_with_word_break(fragment)
          end
        end
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

      def insert_fragment_with_word_break(fragment)
        tokenize(fragment).each do |segment|
          segment_width = if segment == zero_width_space(segment.encoding)
                            0
                          else
                            @document.width_of(segment, kerning: @kerning)
                          end

          if @accumulated_width + segment_width <= @width
            @accumulated_width += segment_width
            shy = soft_hyphen(segment.encoding)
            if segment[-1] == shy
              sh_width = @document.width_of(shy, kerning: @kerning)
              @accumulated_width -= sh_width
            end
            @fragment_output += segment
          else
            if @accumulated_width.zero? && @line_contains_more_than_one_word
              @line_contains_more_than_one_word = false
            end
            end_of_the_line_reached(segment)
            fragment_finished(fragment)
            return false
          end
        end

        fragment_finished(fragment)
        true
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
