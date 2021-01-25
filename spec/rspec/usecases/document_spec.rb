# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Document do
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
      it { is_expected.to have_attributes(title: '', description: '', usecases: []) }
    end

    context 'with one use case' do
      subject { instance.usecases.length }
      let(:descendant_children) { [usecase1] }
      context 'when documentor settings are not set' do
        it { is_expected.to be_zero }
      end
      context 'when documentor settings are set with usecases: true' do
        let(:documentor_settings) { { usecases: true } }
        it { is_expected.to eq 1 }

        context 'with two describe blocks' do
          let(:descendant_children) { [describe, describe] }
          it { is_expected.to be_zero }
        end
        context 'with one describe block and two usecase blocks' do
          let(:descendant_children) { [describe, usecase1, usecase2] }
          it { is_expected.to eq 2 }

          context 'check attribute values' do
            subject { instance.usecases }

            it { is_expected.to include(an_object_having_attributes(key: 'usecase1', title: 'A B C Default Title', usage: '')) }
            it { is_expected.to include(an_object_having_attributes(key: 'usecase2', title: 'My custom title', usage: 'MyClass.load')) }
          end
          context 'check deep hash' do
            subject { instance.to_h }

            it do
              is_expected.to eq(
                title: '',
                description: '',
                usecases: [{
                  key: 'usecase1',
                  title: 'A B C Default Title',
                  summary: '',
                  usage: '',
                  usage_description: '',
                  contents: []
                }, {
                  title: 'My custom title',
                  summary: 'My usecase summary',
                  usage: 'MyClass.load',
                  usage_description: 'My custom usage description',
                  key: 'usecase2',
                  contents: [{
                    title: 'outcome 1',
                    source: '',
                    summary: 'outcome summary 1',
                    type: 'outcome',
                    options: [
                      is_hr: false
                    ]
                  }, {
                    title: 'code 1',
                    source: 'code summary 1',
                    type: 'code',
                    code_type: 'ruby',
                    options: [
                      is_hr: false
                    ]
                  }]
                }]
              )
            end
          end
        end
      end
    end
  end
end
