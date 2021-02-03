# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rspec::Usecases::Groups::Group, :usecases do
  before(:context, :usecases) do
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  include_context 'simple usecases'

  describe '.attribute.* readers' do
    subject { @documentor.document.groups.first }

    it {
      is_expected.to have_attributes(title: 'I am a group',
                                     deep_title: 'Rspec::Usecases::Groups::Group B C I am a group',
                                     summary: '')
    }
  end
end
