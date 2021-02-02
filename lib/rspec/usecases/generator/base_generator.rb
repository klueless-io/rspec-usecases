# frozen_string_literal: true

module Rspec
  module Usecases
    # Generators build meta data in various output formats. JSON, Debug, Markdown etc.
    module Generator
      # Base generator contains helper methods
      class BaseGenerator
        attr_accessor :document
        attr_accessor :output
        attr_accessor :options

        def initialize(document, options = nil)
          @document = document
          @options = options
          @output = ''
        end

        # Write line of text to the output buffer and then add line feed character
        def write_line(line = nil)
          @output = "#{@output}#{line}\n" unless line == ''
        end

        # Write line feed character ot output buffer
        def write_lf
          @output = "#{@output}\n"
        end

        # Print output to console
        def print_output
          puts @output
        end

        # Write the file, force creation of folder if needed
        def write_file(file)
          FileUtils.mkdir_p(File.dirname(file))

          File.write(file, @output)
        end

        # Run the file through prettier and then write back to that file
        def prettier_file(file)
          # npm install -g prettier @prettier/plugin-ruby

          cmd = "prettier --check #{file} --write #{file}"

          puts cmd
          system(cmd)
        end

        # Open the file in vscode
        def open_file_in_vscode(file)
          system("code #{file}")
        end
      end
    end
  end
end
