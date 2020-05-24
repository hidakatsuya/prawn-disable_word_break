# frozen_string_literal: true

require 'test_helper'

class Prawn::DisableWordBreak::LineWrapWithoutWordBreakTest < Test::Unit::TestCase
  include TestHelper

  setup do
    @pdf = create_pdf
    @arranger = Prawn::Text::Formatted::Arranger.new(@pdf)
    @line_wrap = Prawn::DisableWordBreak::LineWrapWithoutWordBreak.new
  end

  sub_test_case 'disable word-breaking' do
    test 'does not break on space' do
      @arranger.format_array = [{ text: 'hello world' }]
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 50,
        document: @pdf
      )
      assert_equal 'hello wo', text_line
    end

    test 'does not break on zero-width space' do
      @arranger.format_array = [{ text: "hello#{Prawn::Text::ZWSP}world" }]
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 50,
        document: @pdf
      )
      assert_equal 'hellowo', text_line
    end

    test 'does not break on tab' do
      @arranger.format_array = [{ text: "hello\tworld" }]
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 50,
        document: @pdf
      )
      assert_equal "hello\tw", text_line
    end

    test 'does not break on hyphens' do
      @arranger.format_array = [{ text: 'hello-world' }]
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 50,
        document: @pdf
      )
      assert_equal 'hello-w', text_line
    end

    test 'does not break on soft hyphens' do
      @arranger.format_array = [{ text: "hello#{Prawn::Text::SHY}world" }]
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 50,
        document: @pdf
      )
      assert_equal 'hellow', text_line
    end
  end

  # Test some examples of the original line_wrap_spec
  # https://github.com/prawnpdf/prawn/blob/master/spec/prawn/text/formatted/line_wrap_spec.rb
  sub_test_case 'keep original behavior' do
    setup { @pdf.font 'Helvetica' }

    test 'does not display soft hyphens except at the end of a line for more than one element in format_array' do
      string1 = @pdf.font.normalize_encoding("hello#{Prawn::Text::SHY}world ")
      string2 = @pdf.font.normalize_encoding("hi#{Prawn::Text::SHY}earth")
      array = [{ text: string1 }, { text: string2 }]
      @arranger.format_array = array
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 300,
        document: @pdf
      )
      assert_equal 'helloworld hiearth', text_line
    end

    test 'does not process UTF-8 chars with default font' do
      array = [{ text: 'Ｔｅｓｔ' }]
      @arranger.format_array = array

      assert_raise(Prawn::Errors::IncompatibleStringEncoding) do
        @line_wrap.wrap_line(
          arranger: @arranger,
          width: 300,
          document: @pdf
        )
      end
    end

    test 'processes UTF-8 chars with UTF-8 font' do
      array = [{ text: 'Ｔｅｓｔ' }]
      @arranger.format_array = array

      @pdf.font font_path('DejaVuSans.ttf')
      text_line = @line_wrap.wrap_line(
        arranger: @arranger,
        width: 300,
        document: @pdf
      )

      assert_equal 'Ｔｅｓｔ', text_line
    end
  end
end
