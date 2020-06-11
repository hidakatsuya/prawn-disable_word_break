# frozen_string_literal: true

$:.unshift File.expand_path('../../lib', __dir__)

require 'prawn/disable_word_break'

require 'pathname'
require 'test/unit'
require 'test/unit/rr'

module TestHelper
  def root_dir
    @test_dir ||= Pathname.new(__dir__)
  end

  def font_path(name)
    root_dir.join('../fonts').join(name)
  end

  def create_pdf
    Prawn::Document.new(margin: 0) do |pdf|
      pdf.font font_path('DejaVuSans.ttf')
    end
  end
end
