# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Renderers::PrintDebugRenderer do
  subject { instance }

  let(:instance) { described_class.new }
  let(:metadata) { nil }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      # it { is_expected.to have_attributes()}
    end
  end
end
