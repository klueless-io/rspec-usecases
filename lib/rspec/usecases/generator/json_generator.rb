# frozen_string_literal: true

require 'json'

module Rspec
  module Usecases
    # Generators build meta data in various output formats. JSON, Debug, Markdown etc.
    module Generator
      # JSON Generator
      class JsonGenerator < Rspec::Usecases::Generator::BaseGenerator
        attr_reader :data

        def run
          generate

          print_output if options.printable?

          return unless options.writable?

          write_file(options.file)

          open_file_in_vscode(options.file) if options.openable?
        end

        def generate
          @data = {
            document: {
              title: document.title,
              description: document.description
            },
            usecases: document.usecases.map(&:to_h)
          }

          @output = JSON.pretty_generate(@data)
        end
      end
    end
  end
end
