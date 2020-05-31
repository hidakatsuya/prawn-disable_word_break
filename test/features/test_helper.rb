# frozen_string_literal: true

$:.unshift File.expand_path('../../lib', __dir__)

require 'prawn/disable_word_break'

require 'pathname'
require 'test/unit'

module TestHelper
  def assert_expected_pdf(test_name, pdf)
    tmp_dir = root_dir.join('tmp')

    diff_pdf = tmp_dir.join("#{test_name}_diff.pdf")
    actual_pdf = tmp_dir.join("#{test_name}_actual.pdf")
    expect_pdf = root_dir.join('expects', "#{test_name}.pdf")

    actual_pdf.binwrite(pdf)

    assert_true system("diff-pdf --output-diff=#{diff_pdf} #{expect_pdf} #{actual_pdf}"),
      "Not match #{expect_pdf.relative_path_from(root_dir)}. Check #{diff_pdf.relative_path_from(root_dir)} for details."
  end

  def root_dir
    @root_dir ||= Pathname.new(__dir__)
  end
end
