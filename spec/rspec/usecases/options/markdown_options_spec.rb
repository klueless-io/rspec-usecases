# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Options::MarkdownOptions do
  subject { instance }

  let(:instance) { described_class.new(config) }
  let(:config) { {} }

  context 'with nil value' do
    let(:config) { nil }

    it {
      is_expected.to have_attributes(empty?: true,
                                     active?: false)
    }
  end

  context 'with :markdown symbol' do
    let(:config) { :markdown }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     format: :detail,
                                     print: true,
                                     pretty: false,
                                     write: false,
                                     file: '',
                                     open: false)
    }
  end

  context 'with true' do
    let(:config) { true }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     format: :detail,
                                     print: true,
                                     pretty: false,
                                     write: false,
                                     file: '',
                                     open: false)
    }
  end

  context 'with false' do
    let(:config) { false }

    it {
      is_expected.to have_attributes(empty?: true,
                                     active?: false,
                                     format: :detail,
                                     print: true,
                                     pretty: false,
                                     write: false,
                                     file: '',
                                     open: false)
    }
  end

  context 'with :markdown hash ' do
    let(:config) { { format: :simple, write: true, file: 'abc.txt' } }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     format: :simple,
                                     print: true,
                                     pretty: false,
                                     write: true,
                                     file: 'abc.txt',
                                     open: false)
    }
  end

  context 'with array' do
    let(:config) { [:pretty, :open, { write: true }, { file: 'abc.txt' }] }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     format: :detail,
                                     print: true,
                                     pretty: true,
                                     write: true,
                                     file: 'abc.txt',
                                     open: true)
    }

    describe 'boolean? accessors' do
      it { is_expected.to be_printable }
      it { is_expected.to be_writable }
      it { is_expected.to be_prettier }
      it { is_expected.to be_openable }
    end
  end

  describe '.to_h' do
    subject { instance.to_h }

    it { is_expected.to eq({ format: :detail, print: true, write: false, file: '', pretty: false, open: false, empty: true }) }
  end
end
