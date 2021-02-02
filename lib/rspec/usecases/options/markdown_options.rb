# frozen_string_literal: true

module Rspec
  module Usecases
    module Options
      # Options for generating MarkDown files from usecases
      class MarkdownOptions < Rspec::Usecases::Options::DynamicOptions
        def initialize(config)
          super(:markdown, config, {
            format: :detail,
            print: true,
            write: false,
            file: '',
            pretty: false,
            open: false
          })
        end

        def printable?
          self.print == true
        end

        def writable?
          write == true
        end

        def prettier?
          pretty == true
        end

        def openable?
          self.open == true
        end
      end
    end
  end
end
