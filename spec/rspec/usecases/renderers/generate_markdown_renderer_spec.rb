# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Renderers::GenerateMarkdownRenderer do
  subject { instance.render }

  let(:instance) { described_class.new(document) }

  let(:document) { Rspec::Usecases::Document.new(example_group) }
  let(:example_group) do
    create_complex_document(markdown_open: false,
                            markdown_prettier: true)
  end
  let(:descendant_parents) { create_descendant_parents }

  describe '#render' do
    # This is a functional test, only turn on when needed
    # it { subject }
  end
end
