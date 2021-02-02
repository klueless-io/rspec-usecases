# frozen_string_literal: true

module Rspec
  module Usecases
    module Contents
      # Content Outcome
      class Outcome < Rspec::Usecases::Contents::BaseContent
        # Note, similar to summary on usecase, but due to
        # metadata inheritance, I needed to use a different
        # property name
        attr_accessor :note

        def initialize(type, example)
          super(type, example)

          @note = example.metadata[:note].to_s
        end

        def to_h
          {
            note: note
          }.merge(super.to_h)
        end
      end
    end
  end
end
