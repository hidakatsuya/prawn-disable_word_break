# frozen_string_literal: true

module Prawn
  module DisableWordBreak
    class LineWrap < Text::Formatted::LineWrap
      # Override
      def initialize_line(options)
        super

        @disable_word_break = if options.key?(:disable_word_break)
          options[:disable_word_break]
        else
          @document.word_break_disabled?
        end
      end

      # Override
      def add_fragment_to_line(fragment)
        if fragment == ''
          true
        elsif fragment == "\n"
          @newline_encountered = true
          false
        else
          add_to_line(fragment)
        end
      end

      def add_to_line(fragment)
        if @disable_word_break
          add_to_line_without_word_wrap(fragment)
        else
          add_to_line_with_word_wrap(fragment)
        end
      end

      def add_to_line_without_word_wrap(fragment)
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

      # This is a part of the original #add_fragment_to_line method:
      # https://github.com/prawnpdf/prawn/blob/master/lib/prawn/text/formatted/line_wrap.rb#L95-L117
      def add_to_line_with_word_wrap(fragment)
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
    end
  end
end
