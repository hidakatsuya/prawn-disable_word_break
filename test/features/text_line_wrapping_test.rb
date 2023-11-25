# frozen_string_literal: true

require "features/test_helper"
require "prawn/disable_word_break"

class TextLineWrappingTest < Test::Unit::TestCase
  include TestHelper

  test "text line-wrapping" do
    Prawn::DisableWordBreak.config.default = false

    pdf = Prawn::Document.new do |doc|
      doc.instance_eval(&renderer_on("DisabledWordBreak is disabled", disable_word_break_option: false))

      doc.start_new_page
      doc.instance_eval(&renderer_on("DisabledWordBreak is enabled", disable_word_break_option: true))

      Prawn::DisableWordBreak.config.default = true
      doc.start_new_page
      doc.instance_eval(&renderer_on("DisabledWordBreak is enabled by config.default", disable_word_break_option: false))
    end

    assert_expected_pdf "text_line_wrapping", pdf.render
  end

  private

  def renderer_on(title, disable_word_break_option: false)
    font_dir = root_dir.join("../fonts")
    box_size = {width: 150, height: 50}

    proc do
      font font_dir.join("DejaVuSans.ttf")

      font_size(20) { text title }
      move_down 10

      text "Spaces"
      move_down 10

      text_for_spaces = "aaaaaa bbbbbb cccccccccccccccc"

      text_box "#text_box:\n#{text_for_spaces}", at: [0, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [0, cursor], *box_size.values }

      formatted_text_box [{text: "#formatted_text_box:\n#{text_for_spaces}"}], at: [180, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [180, cursor], *box_size.values }

      bounding_box [360, cursor], **box_size do
        text "#bounding_box:\n#{text_for_spaces}", disable_word_break: disable_word_break_option
        stroke_bounds
      end

      move_down 20

      text "Tabs"
      move_down 10

      text_for_tabs = "aaaaaa\tbbbbbb\tcccccccccccccccc"

      text_box "#text_box:\n#{text_for_tabs}", at: [0, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [0, cursor], *box_size.values }

      formatted_text_box [{text: "#formatted_text_box:\n#{text_for_tabs}"}],
        at: [180, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [180, cursor], *box_size.values }

      bounding_box [360, cursor], **box_size do
        text "#bounding_box:\n#{text_for_tabs}", disable_word_break: disable_word_break_option
        stroke_bounds
      end

      move_down 20

      text "Hard hyphens"
      move_down 10

      text_for_hard_hyphens = "aaaaaa-bbbbbb-cccccccccccccccc"

      text_box "#text_box:\n#{text_for_hard_hyphens}", at: [0, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [0, cursor], *box_size.values }

      formatted_text_box [{text: "#formatted_text_box:\n#{text_for_hard_hyphens}"}],
        at: [180, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [180, cursor], *box_size.values }

      bounding_box [360, cursor], **box_size do
        text "#bounding_box:\n#{text_for_hard_hyphens}", disable_word_break: disable_word_break_option
        stroke_bounds
      end

      move_down 20

      text "Soft hyphens"
      move_down 10

      shy = Prawn::Text::SHY
      text_for_soft_hyphens = "aaaaaa#{shy}bbbbbb#{shy}cccccccccccccccc"

      text_box "#text_box:\n#{text_for_soft_hyphens}", at: [0, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [0, cursor], *box_size.values }

      formatted_text_box [{text: "#formatted_text_box:\n#{text_for_soft_hyphens}"}],
        at: [180, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [180, cursor], *box_size.values }

      bounding_box [360, cursor], **box_size do
        text "#bounding_box:\n#{text_for_soft_hyphens}", disable_word_break: disable_word_break_option
        stroke_bounds
      end

      move_down 20

      text "Zero width spaces"
      move_down 10

      zwsp = Prawn::Text::ZWSP
      text_for_zwsp = "aaaaaa#{zwsp}bbbbbb#{zwsp}cccccccccccccccc"

      text_box "#text_box:\n#{text_for_zwsp}", at: [0, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [0, cursor], *box_size.values }

      formatted_text_box [{text: "#formatted_text_box:\n#{text_for_zwsp}"}],
        at: [180, cursor], disable_word_break: disable_word_break_option, **box_size

      stroke { rectangle [180, cursor], *box_size.values }

      bounding_box [360, cursor], **box_size do
        text "#bounding_box:\n#{text_for_zwsp}", disable_word_break: disable_word_break_option
        stroke_bounds
      end

      move_down 20

      text "Japanese"
      move_down 10

      font font_dir.join("ipag.ttf") do
        text_box "#text_box:\nああああああああ-いいいいいいい", at: [0, cursor], disable_word_break: disable_word_break_option, **box_size

        stroke { rectangle [0, cursor], *box_size.values }

        formatted_text_box [{text: "#formatted_text_box:\nああああああああ いいいいいいい"}],
          at: [180, cursor], disable_word_break: disable_word_break_option, **box_size

        stroke { rectangle [180, cursor], *box_size.values }

        bounding_box [360, cursor], **box_size do
          text "#bounding_box:\nああああああああ#{zwsp}いいいいいいい", disable_word_break: disable_word_break_option
          stroke_bounds
        end
      end
    end
  end
end
