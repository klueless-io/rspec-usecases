# frozen_string_literal: true

module Rspec
  module Usecases
    module Groups
      # Group can be used as a basic container, it is
      # similar in nature to describe and context but
      # it will enter the flatten_group_hierarchy as
      # it is a known usecase type
      class Group < Rspec::Usecases::Groups::BaseGroup
      end
    end
  end
end
