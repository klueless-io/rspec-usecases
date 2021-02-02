# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Generator::MarkdownGenerator,
               :usecases,
               document_title: 'markdown title',
               document_description: 'markdown description' do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'comprehensive usecases'

  subject { instance }

  let(:document) { @documentor.document }
  let(:instance) { described_class.new(document, document.options.markdown) }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it {
        is_expected.to have_attributes(output: '',
                                       options: be_a(Rspec::Usecases::Options::MarkdownOptions))
      }
    end
  end

  describe '#run' do
    subject { instance.run }

    before do
      document.options.markdown.file = 'docs/test.md'
    end

    # it 'functional test, uncomment only in development' do
    #   document.options.markdown.print = false
    #   document.options.markdown.write = true
    #   document.options.markdown.pretty = true
    #   document.options.markdown.open = true

    #   subject
    # end

    context 'when all options turned of' do
      before do
        document.options.markdown.print = false
        document.options.markdown.write = false
        document.options.markdown.pretty = false
        document.options.markdown.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).not_to receive(:write_file)
        expect(instance).not_to receive(:prettier_file)
        expect(instance).not_to receive(:open_file_in_vscode)
        subject
      end
    end

    context 'when printable?' do
      before do
        document.options.markdown.print = true
        document.options.markdown.write = false
        document.options.markdown.pretty = false
        document.options.markdown.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).to receive(:print_output)
        expect(instance).not_to receive(:write_file)
        expect(instance).not_to receive(:prettier_file)
        expect(instance).not_to receive(:open_file_in_vscode)
        subject
      end
    end

    context 'when writable?' do
      before do
        document.options.markdown.print = false
        document.options.markdown.write = true
        document.options.markdown.pretty = false
        document.options.markdown.open = false
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).to receive(:write_file).with(document.options.markdown.file)
        expect(instance).not_to receive(:prettier_file)
        expect(instance).not_to receive(:open_file_in_vscode)

        subject
      end
    end

    context 'when writable? and prettier? and openable?' do
      before do
        document.options.markdown.print = false
        document.options.markdown.write = true
        document.options.markdown.pretty = true
        document.options.markdown.open = true
      end

      it 'executes the correct methods' do
        expect(instance).to receive(:generate)
        expect(instance).not_to receive(:print_output)
        expect(instance).to receive(:write_file).with(document.options.markdown.file)
        expect(instance).to receive(:prettier_file).with(document.options.markdown.file)
        expect(instance).to receive(:open_file_in_vscode).with(document.options.markdown.file)

        subject
      end
    end
  end
end
