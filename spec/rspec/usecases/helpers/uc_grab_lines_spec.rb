# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Rspec::Usecases::Helpers.uc_grab_lines' do
  include Rspec::Usecases::Helpers

  let(:content) do
    <<~TEXT.strip
            line 1
            line 2
      #{'      '}
            line 4
            line 5
    TEXT
  end

  describe 'uc_grab_lines' do
    subject { as_array(uc_grab_lines(content, lines_to_include)) }

    context 'specific line numbers' do
      let(:lines_to_include) { [1, 3, 5] }

      it { is_expected.to match_array(['line 1', '', 'line 5']) }
    end

    context 'range of line numbers' do
      let(:lines_to_include) { [*(1..4)] }

      it { is_expected.to match_array(['line 1', 'line 2', '', 'line 4']) }
    end

    context 'specific and range of line numbers' do
      let(:lines_to_include) { [1, *(3..4), 5] }

      it { is_expected.to match_array(['line 1', '', 'line 4', 'line 5']) }
    end

    context 'when line number is' do
      let(:lines_to_include) { [0, 1] }

      it 'to low' do
        expect { subject }.to raise_error(StandardError, 'Line numbers must start from 1')
      end
    end

    context 'when line number is' do
      let(:lines_to_include) { [1, 6] }

      it 'to high' do
        expect { subject }.to raise_error(StandardError, 'Line number out of range - content_length: 5 - line_no: 6')
      end
    end
  end

  def as_array(text)
    text.split("\n").compact.collect(&:strip)
  end
end
