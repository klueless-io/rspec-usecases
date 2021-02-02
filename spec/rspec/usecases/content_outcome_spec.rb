# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::ContentOutcome, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  let(:document) { @documentor.document }

  let(:usecase) { document.usecases[0] }
  let(:usecase_outcome) { usecase.contents[0] }
  let(:usecase_code) { usecase.contents[1] }

  context 'handle content and content_outcome differences' do
    context 'nil description' do
      subject { usecase_outcome }
      it {
        is_expected.to be_a(Rspec::Usecases::ContentOutcome)
          .and have_attributes(note: '',
                               title: '',
                               type: 'outcome',
                               source: '# Do nothing',
                               is_hr: false)
      }
    end
  end

  # ----------------------------------------------------------------------
  # configured usecases for the tests above
  # ----------------------------------------------------------------------

  usecase 'usecase: handle content and outcome differences' do
    # aka :usecase_outcome
    outcome do
      # Do nothing
    end
  end
end
