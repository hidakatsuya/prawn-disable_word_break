# frozen_string_literal: true

require "test/unit"
require "test/unit/rr"
require "prawn/disable_word_break"

class PrawnTest < Test::Unit::TestCase
  setup do
    stub(Prawn::DisableWordBreak.config).default { false }
  end

  test "#height_of_formatted(disable_word_break: false)" do
    mock.proxy(Prawn::DisableWordBreak::LineBreakAnywhere).new.never

    Prawn::Document.new.height_of_formatted([{text: "text"}])
  end

  test "#height_of_formatted(disable_word_break: true)" do
    mock.proxy(Prawn::DisableWordBreak::LineBreakAnywhere).new.once

    Prawn::Document.new.height_of_formatted([{text: "text"}], disable_word_break: true)
  end
end
