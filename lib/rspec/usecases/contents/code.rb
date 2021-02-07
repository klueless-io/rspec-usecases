# frozen_string_literal: true

module Rspec
  module Usecases
    module Contents
      # Code
      class Code < Rspec::Usecases::Contents::BaseContent
        # Over ride the source code
        attr_accessor :code

        # def initialize(type, example)
        #   super(type, example)

        #   # @code = example.metadata[:code].to_s
        # end

        # def to_h
        #   {
        #     # code: code
        #   }.merge(super.to_h)
        # end
      end
    end
  end
end
