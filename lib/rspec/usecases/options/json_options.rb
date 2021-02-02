# frozen_string_literal: true

module Rspec
  module Usecases
    module Options
      # Options for turning usecases into JSON objects
      class JsonOptions < Rspec::Usecases::Options::DynamicOptions
        def initialize(config)
          super(:json, config, {
            format: :detail,
            print: true,
            write: false,
            file: '',
            open: false
          })
        end

        def printable?
          self.print == true
        end

        def writable?
          write == true
        end

        def openable?
          self.open == true
        end
      end
    end
  end
end
