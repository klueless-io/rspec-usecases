# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Generator::DebugGenerator,
               :usecases,
               document_title: 'debug title',
               document_description: 'debug description' do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'comprehensive usecases'

  subject { instance }

  let(:document) { @documentor.document }
  let(:instance) { described_class.new(document, document.options.debug) }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it {
        is_expected.to have_attributes(output: '',
                                       options: be_a(Rspec::Usecases::Options::DebugOptions))
      }
    end
  end

  describe '#run' do
    subject { instance.run }

    before do
      document.options.debug.file = 'docs/test.debug.txt'
    end

    # it 'functional test, uncomment only in development' do
    #   document.options.debug.print = true
    #   document.options.debug.write = false
    #   document.options.debug.open = false

    #   subject
    # end

    context 'when all options turned of' do
      before do
        document.options.debug.print = false
        document.options.debug.write = false
        document.options.debug.open = false
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
        document.options.debug.print = true
        document.options.debug.write = false
        document.options.debug.open = false
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
        document.options.debug.print = false
        document.options.debug.write = true
        document.options.debug.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).to receive(:write_file).with(document.options.debug.file)
        expect(instance).not_to receive(:open_file_in_vscode)

        subject
      end
    end

    context 'when writable? and openable?' do
      before do
        document.options.debug.print = false
        document.options.debug.write = true
        document.options.debug.open = true
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).to receive(:write_file).with(document.options.debug.file)
        expect(instance).to receive(:open_file_in_vscode).with(document.options.debug.file)

        subject
      end
    end
  end
end
