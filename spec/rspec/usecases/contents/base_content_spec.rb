# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Contents::BaseContent, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  let(:document) { @documentor.document }

  let(:usecase1) { document.usecases[0] }
  let(:usecase1_content1) { usecase1.contents[0] }
  let(:usecase1_content2) { usecase1.contents[1] }

  let(:usecase2) { document.usecases[1] }
  let(:usecase2_content) { usecase2.contents[0] }

  context 'when missing description' do
    context 'nil description' do
      subject { usecase1_content1 }
      it {
        is_expected.to be_a(Rspec::Usecases::Contents::BaseContent)
          .and have_attributes(title: '',
                               note: '',
                               type: 'outcome',
                               source: '# some text',
                               is_hr: false)
      }
    end
    context 'blank description' do
      subject { usecase1_content2 }
      it {
        is_expected.to have_attributes(title: '',
                                       note: '',
                                       type: 'outcome',
                                       source: '# some text',
                                       is_hr: false)
      }
    end
  end

  context 'with description provided' do
    context 'via main paramater' do
      subject { usecase2_content }
      it { is_expected.to have_attributes(title: 'some title') }
    end
  end

  # ----------------------------------------------------------------------
  # configured usecases for the tests above
  # ----------------------------------------------------------------------

  # aka: usecase1
  usecase 'usecase: when outcome has no description' do
    # aka :usecase1_outcome1
    outcome do
      # some text
    end
    # aka :usecase1_outcome2
    outcome '    ' do
      # some text
    end
  end

  # NOTE: What Rspec calls a description, I call a title
  usecase 'usecase: when outcome has description' do
    # aka :usecase2_outcome
    outcome 'some title' do
      # some text
    end
  end
end
