# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Usecase do
  subject { instance }

  let(:instance) { described_class.new('key1') }

  let(:descendant_parents) { double(parent_groups: []) }
  let(:default_options) { [{ 'is_hr': false }] }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }

      it {
        is_expected.to have_attributes(key: 'key1',
                                       title: '',
                                       usage: '',
                                       usage_description: '',
                                       contents: [])
      }

      it 'valid hash' do
        expect(subject.to_h).to eq(
          key: 'key1',
          title: '',
          summary: '',
          usage: '',
          usage_description: '',
          contents: []
        )
      end
    end
  end

  describe 'build_title' do
    before { subject.build_title(usecase_with_title) }

    context 'usecase has constructed title' do
      let(:usecase_with_title) do
        double('ExampleGroup',
               metadata: { usecase: true },
               example_group: create_descendant_parents,
               descendants: [])
      end

      it { is_expected.to have_attributes(title: 'A B C Default Title') }

      it { expect(subject.to_h).to include(title: 'A B C Default Title') }
    end

    context 'usecase has custom title' do
      let(:usecase_with_title) do
        double('ExampleGroup',
               metadata: { usecase: true, title: 'Custom Title' },
               example_group: create_descendant_parents,
               descendants: [])
      end

      it { is_expected.to have_attributes(title: 'Custom Title') }

      it { expect(subject.to_h).to include(title: 'Custom Title') }
    end
  end

  describe 'build_attributes' do
    before { subject.build_attributes(usecase_with_attributes) }

    context 'usecase has no extra attributes' do
      let(:usecase_with_attributes) do
        double('ExampleGroup',
               metadata: { usecase: true },
               example_group: descendant_parents,
               descendants: [])
      end

      it { is_expected.to have_attributes(summary: '') }
      it { is_expected.to have_attributes(usage: '') }
      it { is_expected.to have_attributes(usage_description: '') }

      it { expect(subject.to_h).to include(summary: '') }
      it { expect(subject.to_h).to include(usage: '') }
      it { expect(subject.to_h).to include(usage_description: '') }
    end

    context 'usecase has summary' do
      let(:usecase_with_attributes) do
        double('ExampleGroup',
               metadata: { usecase: true, summary: 'My summary' },
               example_group: descendant_parents,
               descendants: [])
      end

      it { is_expected.to have_attributes(summary: 'My summary') }

      it { expect(subject.to_h).to include(summary: 'My summary') }
    end

    context 'usecase has usage' do
      let(:usecase_with_attributes) do
        double('ExampleGroup',
               metadata: { usecase: true, usage: 'MyClass.load' },
               example_group: descendant_parents,
               descendants: [])
      end

      it { is_expected.to have_attributes(usage: 'MyClass.load') }

      it { expect(subject.to_h).to include(usage: 'MyClass.load') }
    end

    context 'usecase has usage description' do
      let(:usecase_with_attributes) do
        double('ExampleGroup',
               metadata: { usecase: true, usage_description: 'MyClass.load - description' },
               example_group: descendant_parents,
               descendants: [])
      end

      it { is_expected.to have_attributes(usage_description: 'MyClass.load - description') }

      it { expect(subject.to_h).to include(usage_description: 'MyClass.load - description') }
    end
  end

  describe 'build_content' do
    # before { subject.parse(usecase_with_content) }
    subject { described_class.parse('key1', usecase_with_content) }

    # context 'usecase has no content' do
    #   let(:usecase_with_content) do
    #     double('ExampleGroup',
    #            metadata: { usecase: true },
    #            example_group: descendant_parents,
    #            examples: [],
    #            descendants: [])
    #   end

    #   it { is_expected.to have_attributes(contents: []) }

    #   it { expect(subject.to_h).to include(contents: []) }
    # end

    context 'usecase has content' do
      let(:usecase_with_content) do
        double('ExampleGroup',
               metadata: { usecase: true },
               example_group: descendant_parents,
               examples: [
                 create_content_outcome1,
                 create_content_code1
               ],
               descendants: [])
      end

      it 'has correct content count' do
        expect(subject.contents.length).to eq(2)
      end

      it {
        expect(subject.to_h[:contents]).to include(
          {
            "title": 'outcome 1',
            "source": '',
            "summary": 'outcome summary 1',
            "type": 'outcome',
            "options": default_options
          }
        )
      }
      it {
        expect(subject.to_h[:contents]).to include(
          {
            "title": 'code 1',
            "summary": 'code summary 1',
            "type": 'code',
            "code_type": 'ruby',
            "source": '# some code goes here;',
            "options": default_options
          }
        )
      }
    end
  end
end
