# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'UsecaseAttributes', :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'simple usecases'

  # have_attributes was giving me the shits by making it hard
  # to find the failing attribute, so I created this shared example.
  # It may be useful to use Rspec-its or better still Rspec-given
  shared_examples 'each attribute has' do |attribute_values|
    attribute_values.each_key do |attribute_name|
      value = attribute_values[attribute_name]
      it "is expected to have .#{attribute_name} #{if value.nil?
                                                     'be nil'
                                                   else
                                                     value == '' ? 'be empty' : 'eq '
                                                   end}#{value}" do
        expect(target.send(attribute_name)).to eq(value)
      end
    end
  end

  describe '.attribute.* readers' do
    subject { @documentor.document.groups.first.groups }
    let(:groups) { @documentor.document.groups.first.groups }

    context '1st group' do
      let(:target) { groups[0] }

      it_behaves_like 'each attribute has',
                      title: 'Simple usecase block',
                      deep_title: 'UsecaseAttributes B C I am a group Simple usecase block',
                      usage: '',
                      usage_description: '',
                      summary: '',
                      contents: [],
                      groups: []
    end

    context '2nd group' do
      let(:target) { groups[1] }

      it_behaves_like 'each attribute has',
                      title: 'Override Title',
                      deep_title: 'UsecaseAttributes B C I am a group Override Title',
                      usage: 'Array.new',
                      usage_description: 'Create a new array',
                      summary: 'Will all usecase attributes',
                      groups: []

      context '1st content' do
        let(:target) { groups[1].contents[0] }

        it_behaves_like 'each attribute has',
                        category: :code,
                        type: :ruby
      end

      context '2nd content' do
        let(:target) { groups[1].contents[1] }

        it_behaves_like 'each attribute has',
                        category: :content,
                        type: :outcome,
                        title: 'this outcome has a note'
      end
    end
  end
end
