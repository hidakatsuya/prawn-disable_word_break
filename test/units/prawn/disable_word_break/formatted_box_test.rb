# frozen_string_literal: true

require 'units/test_helper'

class Prawn::DisableWordBreak::FormattedBoxTest < Test::Unit::TestCase
  include TestHelper

  sub_test_case 'Prawn::Text::Formatted::Box' do
    setup do
      @formatted_box = Prawn::Text::Formatted::Box.new([{ text: 'text' }], document: create_pdf)
    end

    test '@line_wrap' do
      assert_instance_of Prawn::DisableWordBreak::LineWrap, @formatted_box.instance_variable_get(:@line_wrap)
    end
  end

  sub_test_case 'Prawn::Text::Box' do
    setup do
      @box = Prawn::Text::Box.new([{ text: 'text' }], document: create_pdf)
    end

    test '@line_wrap' do
      assert_instance_of Prawn::DisableWordBreak::LineWrap, @box.instance_variable_get(:@line_wrap)
    end
  end
end
