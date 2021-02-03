# frozen_string_literal: true

module Rspec
  module Usecases
    # Generators build meta data in various output formats. JSON, Debug, Markdown etc.
    module Generator
      # Debug Generator helps to visualize the data that is collected
      # from use cases
      class DebugGenerator < Rspec::Usecases::Generator::BaseGenerator
        def run
          @key_width = 30
          @indent_size = 0

          generate

          print_output if options.printable?

          return unless options.writable?

          write_file(options.file)

          open_file_in_vscode(options.file) if options.openable?
        end

        def generate
          print_document_header
          print_groups(document.groups)
        end

        private

        def print_document_header
          write_line '*' * 100
          kv 'Title', document.title if document.title
          kv 'Description', document.description if document.description
        end

        def print_groups(groups)
          groups.each { |usecase| print_usecase(usecase) }
        end

        def print_usecase(usecase)
          print_usecase_header(usecase)

          indent
          usecase.contents.each { |content| print_usecase_content(content) }
          print_groups(usecase.groups)
          outdent
        end

        # rubocop:disable Metrics/AbcSize
        def print_usecase_header(usecase)
          write_line '=' * 100
          kv 'Key'              , usecase.key if usecase.key
          kv 'Title'            , usecase.title if usecase.title
          kv 'Deep Title'       , usecase.deep_title if usecase.deep_title
          kv 'Summary'          , usecase.summary if usecase.summary
          kv 'Usage'            , usecase.usage if usecase.usage
          kv 'Usage Description', usecase.usage_description if usecase.usage_description
        end
        # rubocop:enable Metrics/AbcSize

        # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
        def print_usecase_content(content)
          write_line '-' * 100
          kv 'Title'    , content.title if content.title != ''
          kv 'Type'     , content.type if content.type != ''

          # Used by outcome
          kv 'Note'     , content.note if content.respond_to?('note') && content.note != ''

          # Used by code
          kv 'Code'     , content.code if content.respond_to?('code') && content.code != ''
          kv 'Code Type', content.code_type if content.respond_to?('code_type') && content.code_type != ''
          wl content.source if content.respond_to?('source') && content.source != ''
        end
        # rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize

        def wl(value)
          write_line "#{indentation}#{value}"
        end

        def kv(key, value, key_width = @key_width)
          key_width -= @indent_size
          write_line "#{indentation}#{green(key.to_s.ljust(key_width))}: #{value}"
        end

        def indentation
          ' ' * @indent_size
        end

        def green(value)
          "\033[32m#{value}\033[0m"
        end

        def indent
          @indent_size += 2
        end

        def outdent
          @indent_size -= 2
        end
      end
    end
  end
end
