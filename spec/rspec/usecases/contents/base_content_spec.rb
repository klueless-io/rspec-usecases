# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Contents::BaseContent, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  let(:document) { @documentor.document }

  let(:usecase1) { document.groups[0] }
  let(:usecase1_content) { usecase1.contents[0] }
  let(:usecase1_code) { usecase1.contents[1] }

  let(:usecase2) { document.groups[1] }
  let(:usecase2_item) { usecase2.contents[0] }
  let(:usecase2_code) { usecase2.contents[1] }

  context 'when missing description' do
    context 'nil description' do
      subject { usecase1_content }
      it { is_expected.to have_attributes(title: '') }
    end
    context 'blank description' do
      subject { usecase1_code }
      it { is_expected.to have_attributes(title: '') }
    end
  end

  context 'with description provided' do
    subject { usecase2_item }
    it { is_expected.to have_attributes(title: 'some title') }
  end

  context 'when category is code' do
    context 'unknown code type' do
      subject { usecase1_code }
      it { is_expected.to have_attributes(category: :code, type: :unknown, source: '# some text') }
    end
    context 'ruby code type' do
      subject { usecase2_code }
      it { is_expected.to have_attributes(category: :code, type: :ruby, source: '# some ruby') }
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
    # aka :usecase1_code
    code '    ' do
      # some text
    end
  end

  # NOTE: What Rspec calls a description, I call a title
  usecase 'usecase: when outcome has description' do
    # aka :usecase2_outcome
    item 'some title' do
      # some text
    end

    ruby 'some ruby' do
      # some ruby
    end
  end
end
