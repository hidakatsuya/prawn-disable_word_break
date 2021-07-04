# frozen_string_literal: true

$:.unshift File.expand_path('../../lib', __dir__)

require 'prawn'

require 'pathname'
require 'test/unit'
require 'pdf_matcher/testing/test_unit_adapter'

module TestHelper
  def assert_expected_pdf(test_name, pdf)
    tmp_dir = root_dir.join('tmp')

    diff_pdf = tmp_dir.join("#{test_name}_diff.pdf")
    actual_pdf = tmp_dir.join("#{test_name}_actual.pdf")
    expect_pdf = root_dir.join('expects', "#{test_name}.pdf")

    actual_pdf.binwrite(pdf)

    assert_match_pdf expect_pdf, actual_pdf, output_diff: diff_pdf
  end

  def root_dir
    @root_dir ||= Pathname.new(__dir__)
  end
end
