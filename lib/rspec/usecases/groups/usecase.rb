# frozen_string_literal: true

module Rspec
  module Usecases
    module Groups
      # A usecase stores documentation for a single code usage scenario.
      class Usecase < Rspec::Usecases::Groups::BaseGroup
        # Usage contains a sample on how to call some code
        attr_reader :usage

        # Usage description gives extra details to support the usage example
        attr_reader :usage_description

        def build_attributes(example_group)
          super(example_group)

          @usage = example_group.metadata[:usage] || ''
          @usage_description = example_group.metadata[:usage_description] || ''
        end

        def to_h
          {
            usage: usage,
            usage_description: usage_description
          }.merge(super.to_h)
        end
      end
    end
  end
end
