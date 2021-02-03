# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Contents::Content, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  let(:document) { @documentor.document }

  let(:group) { document.groups[0] }
  let(:content) { group.contents[0] }
  let(:outcome) { group.contents[1] }
  let(:item) { group.contents[2] }

  context 'with content blocks' do
    context 'general content' do
      subject { content }
      it { is_expected.to have_attributes(category: :content, title: 'some content', type: :content) }
    end
    context 'outcome - often used for results from previous content calls' do
      subject { outcome }
      it { is_expected.to have_attributes(category: :content, title: 'some outcome', type: :outcome) }
    end
    context 'item - useful for bullet points' do
      subject { item }
      it { is_expected.to have_attributes(category: :content, title: 'some item', type: :item) }
    end
  end

  # ----------------------------------------------------------------------
  # configured usecases for the tests above
  # ----------------------------------------------------------------------

  # aka: usecase
  usecase 'handle content' do
    content 'some content' do
      # some content
    end
    outcome 'some outcome' do
      # some outcome
    end
    item 'some item' do
      # some item
    end
  end
end
