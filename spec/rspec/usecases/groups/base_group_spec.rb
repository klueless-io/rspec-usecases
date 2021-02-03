# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Groups::BaseGroup, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'simple usecases'

  describe '.attribute.* readers' do
    subject { @documentor.document.groups.first.groups }

    it {
      is_expected.to include(an_object_having_attributes(key: 'RSpec::ExampleGroups::RspecUsecasesGroupsBaseGroup::B::C::IAmAGroup::SimpleUsecaseBlock',
                                                         title: 'Simple usecase block',
                                                         deep_title: 'Rspec::Usecases::Groups::BaseGroup B C I am a group Simple usecase block',
                                                         usage: '',
                                                         usage_description: '',
                                                         summary: '',
                                                         contents: [],
                                                         groups: []))
    }
    it {
      is_expected.to include(an_object_having_attributes(key: 'RSpec::ExampleGroups::RspecUsecasesGroupsBaseGroup::B::C::IAmAGroup::FullyConfiguredUsecaseBlock',
                                                         title: 'Override Title',
                                                         deep_title: 'Rspec::Usecases::Groups::BaseGroup B C I am a group Override Title',
                                                         usage: 'Array.new',
                                                         usage_description: 'Create a new array',
                                                         summary: 'Will all usecase attributes',
                                                         contents: include(an_object_having_attributes(type: 'outcome', title: 'this outcome has a note'),
                                                                           an_object_having_attributes(type: 'code', code_type: 'ruby')),
                                                         groups: []))
    }
  end
end
