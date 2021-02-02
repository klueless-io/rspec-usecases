# frozen_string_literal: true

module Rspec
  module Usecases
    # Debug Options
    module Options
      # Options for debugging usecases objects
      class DebugOptions < Rspec::Usecases::Options::DynamicOptions
        def initialize(config)
          super(:debug, config, {
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
