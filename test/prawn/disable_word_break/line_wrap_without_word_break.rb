# frozen_string_literal: true

require 'test_helper'

class Prawn::DisableWordBreak::LineWrapWithoutWordBreakTest < Test::Unit::TestCase
  include TestHelper

  setup do
    @pdf = create_pdf
    @arranger = Prawn::Text::Formatted::Arranger.new(@pdf)
    @line_wrap = Prawn::DisableWordBreak::LineWrapWithoutWordBreak.new
  end

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
end
