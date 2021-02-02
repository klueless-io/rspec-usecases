# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Options::DocumentOptions do
  subject { instance }

  let(:instance) { described_class.new(config) }
  let(:config) { {} }

  context 'with nil value' do
    it {
      is_expected.to have_attributes(json: have_attributes(empty?: true, active?: false),
                                     debug: have_attributes(empty?: true, active?: false),
                                     markdown: have_attributes(empty?: true, active?: false))
    }
  end

  context 'with mixed configuration value' do
    let(:config) do
      {
        json: :json,
        debug: { format: :simple, write: true, file: 'abc.txt' },
        markdown: [:pretty, :open, { write: true }, { file: 'abc.txt' }]
      }
    end
    it {
      is_expected.to have_attributes(json: have_attributes(empty?: false,
                                                           active?: true,
                                                           format: :detail,
                                                           print: true,
                                                           write: false,
                                                           file: '',
                                                           open: false),
                                     debug: have_attributes(empty?: false,
                                                            active?: true,
                                                            format: :simple,
                                                            print: true,
                                                            write: true,
                                                            file: 'abc.txt',
                                                            open: false),
                                     markdown: have_attributes(empty?: false,
                                                               active?: true,
                                                               format: :detail,
                                                               print: true,
                                                               pretty: true,
                                                               write: true,
                                                               file: 'abc.txt',
                                                               open: true))
    }
  end

  describe '.to_h' do
    subject { instance.to_h }

    it {
      is_expected.to eq(
        {
          json: { format: :detail, print: true, write: false, file: '', open: false, empty: true },
          debug: { format: :detail, print: true, write: false, file: '', open: false, empty: true },
          markdown: { format: :detail, print: true, write: false, file: '', pretty: false, open: false, empty: true }
        }
      )
    }
  end
end
