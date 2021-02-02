# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Options::DynamicOptions do
  subject { instance }

  let(:instance) { described_class.new(option_key, value, api) }
  let(:option_key) { :some_key }
  let(:api) do
    {
      key1: 'key1',
      key2: :key2,
      key3: nil,
      key4: false,
      key5: false
    }
  end

  context 'with nil value' do
    let(:value) { nil }

    it {
      is_expected.to have_attributes(empty?: true,
                                     active?: false,
                                     key1: 'key1',
                                     key2: :key2,
                                     key3: nil,
                                     key4: false,
                                     key5: false)
    }
  end

  context 'with empty hash value' do
    let(:value) { {} }

    it {
      is_expected.to have_attributes(empty?: true,
                                     active?: false,
                                     key1: 'key1',
                                     key2: :key2,
                                     key3: nil,
                                     key4: false,
                                     key5: false)
    }
  end

  context 'with a symbol value that matches the option_key' do
    let(:value) { :some_key }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     key1: 'key1',
                                     key2: :key2,
                                     key3: nil,
                                     key4: false,
                                     key5: false)
    }
  end

  context 'with hash as a value' do
    let(:value) { { key1: 'set me', key3: 'and me', key4: true } }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     key1: 'set me',
                                     key2: :key2,
                                     key3: 'and me',
                                     key4: true,
                                     key5: false)
    }
  end

  context 'with array of values' do
    let(:value) { [:key4 , :key5, { key3: 'set 3' }] }

    it {
      is_expected.to have_attributes(empty?: false,
                                     active?: true,
                                     key1: 'key1',
                                     key2: :key2,
                                     key3: 'set 3',
                                     key4: true,
                                     key5: true)
    }
  end
end
