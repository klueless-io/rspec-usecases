# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Generator::JsonGenerator,
               :usecases,
               document_title: 'json title',
               document_description: 'json description' do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'comprehensive usecases'

  subject { instance }

  let(:document) { @documentor.document }
  let(:instance) { described_class.new(document, document.options.json) }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it {
        is_expected.to have_attributes(output: '',
                                       options: be_a(Rspec::Usecases::Options::JsonOptions))
      }
    end
  end

  describe '#run' do
    subject { instance.run }

    before do
      document.options.json.file = 'docs/test.json'
    end

    # it 'functional test, uncomment only in development' do
    #   document.options.json.print = false
    #   document.options.json.write = true
    #   document.options.json.open = true

    #   subject
    # end

    context 'when all options turned of' do
      before do
        document.options.json.print = false
        document.options.json.write = false
        document.options.json.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).not_to receive(:write_file)
        expect(instance).not_to receive(:open_file_in_vscode)
        subject
      end
    end

    context 'when printable?' do
      before do
        document.options.json.print = true
        document.options.json.write = false
        document.options.json.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).to receive(:print_output)
        expect(instance).not_to receive(:write_file)
        expect(instance).not_to receive(:open_file_in_vscode)
        subject
      end
    end

    context 'when writable?' do
      before do
        document.options.json.print = false
        document.options.json.write = true
        document.options.json.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).to receive(:write_file).with(document.options.json.file)
        expect(instance).not_to receive(:open_file_in_vscode)

        subject
      end
    end

    context 'when writable? and openable?' do
      before do
        document.options.json.print = false
        document.options.json.write = true
        document.options.json.open = true
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).to receive(:write_file).with(document.options.json.file)
        expect(instance).to receive(:open_file_in_vscode).with(document.options.json.file)

        subject
      end
    end
  end
end
