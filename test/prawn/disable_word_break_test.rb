# frozen_string_literal: true

require 'test_helper'

class Prawn::DisableWordBreakTest < Test::Unit::TestCase
  include TestHelper

  test 'replaces line_wrap of Formatted::Box' do
    formatted_box = Prawn::Text::Formatted::Box.new([{ text: 'text' }], document: create_pdf)
    assert_instance_of Prawn::DisableWordBreak::LineWrapWithoutWordBreak, formatted_box.instance_variable_get(:@line_wrap)
  end

  test 'replaces line_wrap of Box' do
    box = Prawn::Text::Box.new('string', document: create_pdf)
    assert_instance_of Prawn::DisableWordBreak::LineWrapWithoutWordBreak, box.instance_variable_get(:@line_wrap)
  end
end
