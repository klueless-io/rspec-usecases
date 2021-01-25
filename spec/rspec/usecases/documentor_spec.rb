# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Documentor do
  subject { instance }

  let(:instance) { described_class.new(root_example_group) }

  let(:documentor_settings) { {} }

  let(:root_example_group) { create_example_group }
  let(:descendant_parents) { create_descendant_parents }
  let(:descendant_children) { [] }
  let(:describe) { create_describe }
  let(:usecase1) { create_usecase1 }
  let(:usecase2) { create_usecase2 }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it { is_expected.to have_attributes(json?: false, debug?: false, markdown?: false) }
    end

    context 'all renderers turned on' do
      let(:documentor_settings) { { json: true , debug: true, markdown: true } }
      it { is_expected.to have_attributes(json?: true, debug?: true, markdown?: true) }

      it 'has configured renderers' do
        expect(subject.renderers.length).to eq 3
      end
    end

    context 'rendering' do
      let(:descendant_children) { [describe, usecase1, usecase2] }
      let(:documentor_settings) do
        { usecases: true,
          json: json,
          debug: debug,
          markdown: markdown,
          document_title: 'title',
          document_description: 'description' }
      end
      let(:json) { false }
      let(:debug) { false }
      let(:markdown) { false }

      context 'json' do
        let(:json) { true }
        it { is_expected.to have_attributes(json?: true, debug?: false, markdown?: false) }

        context 'render' do
          subject { instance.render }

          it { subject }
        end
      end

      context 'debug' do
        let(:debug) { true }
        it { is_expected.to have_attributes(json?: false, debug?: true, markdown?: false) }

        context 'render' do
          subject { instance.render }

          it { subject }
        end
      end

      context 'markdown' do
        let(:markdown) { true }
        it { is_expected.to have_attributes(json?: false, debug?: false, markdown?: true) }

        context 'render' do
          subject { instance.render }

          it { subject }
        end
      end
    end
  end
end