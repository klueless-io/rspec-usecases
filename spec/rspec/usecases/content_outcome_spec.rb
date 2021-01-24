# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::ContentOutcome do
  subject { instance }

  let(:instance) { Rspec::Usecases::Content.parse(example) }

  describe '#parse' do
    let(:example) { create_content_outcome1 }

    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Rspec::Usecases::ContentOutcome }
      it {
        is_expected.to have_attributes(title: 'outcome 1',
                                       summary: 'outcome summary 1',
                                       type: 'outcome')
      }

      # it { puts subject.to_h }
      # it { puts subject.debug }
    end
  end
end
