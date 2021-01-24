# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Usecase do
  subject { instance }

  let(:instance) { described_class.new }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      # it { is_expected.to have_attributes()}
    end
  end


end
