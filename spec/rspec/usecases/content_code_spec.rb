# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::ContentCode do
  subject { instance }

  let(:instance) { Rspec::Usecases::Content.parse(example) }

  describe '#parse' do
    let(:example) { create_content_code1 }

    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it { is_expected.to be_a Rspec::Usecases::ContentCode }
      it {
        is_expected.to have_attributes(title: 'code 1',
                                       type: 'code',
                                       code_type: 'ruby',
                                       summary: 'code summary 1',
                                       source: '# some code goes here;')
      }

      # it { puts subject.to_h }
      # it { puts subject.debug }
    end
  end
end
