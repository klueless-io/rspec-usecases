# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Groups::BaseGroup, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'simple usecases'

  describe '.attribute.* readers' do
    subject { @documentor.document.groups }

    it {
      is_expected.to include(an_object_having_attributes(key: 'RSpec::ExampleGroups::RspecUsecasesGroupsBaseGroup::B::C::SimpleUsecaseBlock',
                                                         title: 'Simple usecase block',
                                                         deep_title: 'Rspec::Usecases::Groups::BaseGroup B C Simple usecase block',
                                                         usage: '',
                                                         usage_description: '',
                                                         summary: '',
                                                         contents: [],
                                                         groups: []))
    }
    it {
      is_expected.to include(an_object_having_attributes(key: 'RSpec::ExampleGroups::RspecUsecasesGroupsBaseGroup::B::C::FullyConfiguredUsecaseBlock',
                                                         title: 'Override Title',
                                                         deep_title: 'Rspec::Usecases::Groups::BaseGroup B C Override Title',
                                                         usage: 'Array.new',
                                                         usage_description: 'Create a new array',
                                                         summary: 'Will all usecase attributes',
                                                         contents: include(an_object_having_attributes(type: 'outcome', title: 'this outcome has a note'),
                                                                           an_object_having_attributes(type: 'code', code_type: 'ruby')),
                                                         groups: []))
    }
  end

  describe '#to_h' do
    context 'simple usecase' do
      subject { @documentor.document.groups[0].to_h }
      it {
        is_expected.to eq({ key: 'RSpec::ExampleGroups::RspecUsecasesGroupsBaseGroup::B::C::SimpleUsecaseBlock',
                            title: 'Simple usecase block',
                            deep_title: 'Rspec::Usecases::Groups::BaseGroup B C Simple usecase block',
                            usage: '',
                            usage_description: '',
                            summary: '',
                            contents: [],
                            groups: [] })
      }
    end
    context 'simple usecase' do
      subject { @documentor.document.groups[1].to_h }
      it do
        is_expected.to eq({ key: 'RSpec::ExampleGroups::RspecUsecasesGroupsBaseGroup::B::C::FullyConfiguredUsecaseBlock',
                            title: 'Override Title',
                            deep_title: 'Rspec::Usecases::Groups::BaseGroup B C Override Title',
                            summary: 'Will all usecase attributes',
                            usage: 'Array.new',
                            usage_description: 'Create a new array',
                            contents: [
                              { note: 'outcome note', title: 'this outcome has a note', type: 'outcome', source: '# Source code goes here', is_hr: true },
                              { code_type: 'ruby', note: '', title: 'this is some ruby code', type: 'code', source: '# Source code goes here', is_hr: false }
                            ],
                            groups: [] })
      end
    end
  end
end
