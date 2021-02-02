# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Documentor - Custom Settings',
               :usecases,
               :skip_render,
               :json,
               :debug,
               markdown: { pretty: true, open: true, file: 'docs/documentor_custom_settings.md' },
               document_title: 'Document title for custom settings',
               document_description: 'Document description for custom settings' do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  describe '.document' do
    subject { @documentor.document }

    it { is_expected.not_to be_nil }

    it 'has default settings' do
      is_expected.to have_attributes(
        options: have_attributes(json: have_attributes(active?: true),
                                 debug: have_attributes(active?: true),
                                 markdown: have_attributes(active?: true,
                                                           file: 'docs/documentor_custom_settings.md',
                                                           pretty: true,
                                                           open: true)),
        skip_render?: true,
        title: 'Document title for custom settings',
        description: 'Document description for custom settings',
        usecases: []
      )
    end

    describe '.to_h' do
      subject { @documentor.document.options.to_h }

      it {
        is_expected.to eq({
                            json: { format: :detail, print: true, write: false, file: '', open: false, empty: false },
                            debug: { format: :detail, print: true, write: false, file: '', open: false, empty: false },
                            markdown: { format: :detail, print: true, write: false, file: 'docs/documentor_custom_settings.md', pretty: true, open: true, empty: false }
                          })
      }
    end
  end

  describe '.generators' do
    subject { @documentor.generators }

    it { is_expected.not_to be_nil }
    it do
      expect(subject).to include(be_a(Rspec::Usecases::Generator::JsonGenerator),
                                 be_a(Rspec::Usecases::Generator::DebugGenerator),
                                 be_a(Rspec::Usecases::Generator::MarkdownGenerator))
    end
  end
end
