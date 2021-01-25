# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Renderers::PrintDebugRenderer do
  subject { described_class.new.render(document) }

  let(:document) { Rspec::Usecases::Document.new(example_group) }
  let(:example_group) { create_complex_document(debug: true) }
  let(:descendant_parents) { create_descendant_parents }

  describe '#render' do
    it { subject }
  end
end
