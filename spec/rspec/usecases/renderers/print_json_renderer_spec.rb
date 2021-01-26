# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Renderers::PrintJsonRenderer do
  subject { instance.render }

  let(:instance) { described_class.new(document) }

  let(:document) { Rspec::Usecases::Document.new(example_group) }
  let(:example_group) { create_complex_document }
  let(:descendant_parents) { create_descendant_parents }

  describe '#render' do
    it { subject }
  end
end
