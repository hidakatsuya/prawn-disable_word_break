# frozen_string_literal: true

require 'units/test_helper'

class Prawn::DisableWordBreak::DisablerTest < Test::Unit::TestCase
  include TestHelper

  setup { @pdf = create_pdf }

  test '#disable_word_break' do
    @pdf.disable_word_break do
      assert_true @pdf.word_break_disabled?
    end
    assert_false @pdf.word_break_disabled?
  end

  test '#word_break' do
    @pdf.word_break(true) do
      assert_true @pdf.word_break_disabled?
    end
    assert_false @pdf.word_break_disabled?

    @pdf.word_break(false) do
      assert_false @pdf.word_break_disabled?
    end
    assert_false @pdf.word_break_disabled?
  end

  test '#word_break_disabled?' do
    assert_false @pdf.word_break_disabled?

    Prawn::DisableWordBreak.config.default = true

    assert_true @pdf.word_break_disabled?
  ensure
    Prawn::DisableWordBreak.config.default = false
  end
end
