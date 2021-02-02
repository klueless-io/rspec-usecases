# frozen_string_literal: true

module Rspec
  module Usecases
    module Contents
      # Code
      class Code < Rspec::Usecases::Contents::BaseContent
        # # Source code
        # attr_accessor :code

        # Type of code, ruby, javascript, css etc.
        attr_accessor :code_type

        # Note
        attr_accessor :note

        def initialize(type, example)
          super(type, example)

          @code_type = example.metadata[:code_type].to_s
          @note = example.metadata[:note].to_s
        end

        def to_h
          {
            code_type: code_type,
            note: note
          }.merge(super.to_h)
        end
      end
    end
  end
end
