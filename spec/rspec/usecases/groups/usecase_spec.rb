# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'UsecaseAttributes', :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  subject { @documentor.document.usecases }

  context 'check attribute value' do
    it {
      is_expected.to include(an_object_having_attributes(key: 'RSpec::ExampleGroups::UsecaseAttributes::B::C::SimpleUsecaseBlock',
                                                         title: 'Simple usecase block',
                                                         deep_title: 'UsecaseAttributes B C Simple usecase block',
                                                         usage: '',
                                                         usage_description: '',
                                                         summary: '',
                                                         contents: [],
                                                         usecases: []))
    }
    it {
      is_expected.to include(an_object_having_attributes(key: 'RSpec::ExampleGroups::UsecaseAttributes::B::C::FullyConfiguredUsecaseBlock',
                                                         title: 'Override Title',
                                                         deep_title: 'UsecaseAttributes B C Override Title',
                                                         usage: 'Array.new',
                                                         usage_description: 'Create a new array',
                                                         summary: 'Will all usecase attributes',
                                                         contents: [],
                                                         usecases: []))
    }
  end

  describe 'B' do
    context 'C' do
      usecase 'Simple usecase block' do
        # Nothing to see here
      end

      usecase 'Fully configured usecase block',
              title: 'Override Title',
              summary: 'Will all usecase attributes',
              usage: 'Array.new',
              usage_description: 'Create a new array' do
        # Nothing to see here
      end
    end
  end
end
