# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Documentor - Default Settings', :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  describe '.document' do
    subject { @documentor.document }

    it { is_expected.not_to be_nil }

    it 'has default settings' do
      is_expected.to have_attributes(
        options: have_attributes(json: have_attributes(active?: false),
                                 debug: have_attributes(active?: false),
                                 markdown: have_attributes(active?: false)),
        skip_render?: false,
        title: '',
        description: '',
        usecases: []
      )
    end
  end

  describe '.generators' do
    subject { @documentor.generators }

    it { is_expected.not_to be_nil }
    it { is_expected.to eq([]) }
  end
end
