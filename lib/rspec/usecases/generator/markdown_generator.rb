# frozen_string_literal: true

module Rspec
  module Usecases
    # Generators build meta data in various output formats. JSON, Debug, Markdown etc.
    module Generator
      # Markdown generator can build a markdown documentation file
      # based on the document content
      class MarkdownGenerator < Rspec::Usecases::Generator::BaseGenerator
        # rubocop:disable Metrics/AbcSize
        def run
          @key_width = 30
          @indent_size = 0

          generate

          print_output if options.printable?

          return unless options.writable?

          write_file(options.file)
          prettier_file(options.file) if options.prettier?

          open_file_in_vscode(options.file) if options.openable?
        end
        # rubocop:enable Metrics/AbcSize

        def generate
          print_document_header
          print_usecases(document.usecases)
        end

        private

        def print_document_header
          h1 document.title
          write_line document.description
          write_lf
        end

        def print_usecases(usecases)
          usecases.each { |usecase| print_usecase(usecase) }
        end

        def print_usecase(usecase)
          h2 usecase.title
          write_lf
          print_summary(usecase)
          print_usage(usecase)
          print_contents(usecase)
        end

        def print_summary(usecase)
          return unless usecase.summary

          write_line usecase.summary
          write_lf
        end

        def print_usage(usecase)
          return if usecase.usage == ''

          h3 usecase.usage
          write_lf

          return unless usecase.usage_description

          write_line usecase.usage_description
          write_lf
        end

        def print_contents(usecase)
          return if usecase.contents.empty?

          usecase.contents.each do |content|
            write_line '---' if content.is_hr

            render_outcome(content) if content.type == 'outcome'
            render_code(content) if content.type == 'code'
          end

          print_usecases(usecase.usecases)
        end

        def render_outcome(content)
          bullet content.title
          write_line content.note if content.note
        end

        def render_code(content)
          h4 content.title
          # write_line content.note if content.note
          render_code_block(content.source, content.code_type) unless content.source == ''
        end

        def render_code_block(source, code_type)
          write_line "```#{code_type}"
          write_line source
          write_line '```'
        end

        def h1(title)
          write_line("# #{title}") if title != ''
        end

        def h2(title)
          write_line("## #{title}") if title != ''
        end

        def h3(title)
          write_line("### #{title}") if title != ''
        end

        def h4(title)
          write_line("#### #{title}") if title != ''
        end

        def h5(title)
          write_line("##### #{title}") if title != ''
        end

        def h6(title)
          write_line("###### #{title}") if title != ''
        end

        def bullet(title)
          write_line("- #{title}") if title != ''
        end

        def hr
          write_line '---'
        end
      end
    end
  end
end
