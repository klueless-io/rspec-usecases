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
          print_groups(document.groups)
        end

        private

        def print_document_header
          heading 1, document.title
          write_line document.description
          write_lf
        end

        def print_groups(groups)
          groups.each do |group|
            print_group(group) if group.type == :group
            print_usecase(group) if group.type == :usecase
          end
        end

        def print_group(usecase)
          print_groups(usecase.groups)
          print_summary(usecase)
          print_contents(usecase)
          print_groups(usecase.groups)
        end

        def print_usecase(usecase)
          # h2
          heading usecase.heading_level, usecase.title
          write_lf
          print_summary(usecase)
          print_usage(usecase)
          print_contents(usecase)
          print_groups(usecase.groups)
        end

        def print_summary(usecase)
          return unless usecase.summary

          write_line usecase.summary
          write_lf
        end

        def print_usage(usecase)
          return if usecase.usage == ''

          # # h3
          # heading usecase.heading_level+1, usecase.usage
          block_quotes usecase.usage
          write_lf

          return unless usecase.usage_description

          write_line usecase.usage_description
          write_lf
        end

        def print_contents(usecase)
          return if usecase.contents.empty?

          usecase.contents.each do |content|
            render_write_line(content)

            render_content(content)
            render_code(content)
          end
        end

        def render_write_line(content)
          write_line '---' if content.is_hr || (content.category == :content && content.type == :hr)
        end

        def render_content(content)
          return unless content.category == :content

          bullet content.title
          write_line content.note if content.note

          return if content.source == ''

          if content.type == :outcome
            block_quotes content.source
          else
            render_code_block(content.source, :ruby)
          end
        end

        def render_code(content)
          return unless content.category == :code

          heading 4, content.title
          write_line content.note if content.note
          render_code_block(content.source, content.type) unless content.source == ''
        end

        def render_code_block(source, code_type)
          code_type = nil if code_type == :unknown
          write_line "```#{code_type}"
          write_line source
          write_line '```'
        end

        def heading(level, title)
          hashes = '#' * level

          write_line("#{hashes} #{title}") if title != ''
        end

        # def h1(title)
        #   write_line("# #{title}") if title != ''
        # end

        # def h2(title)
        #   write_line("## #{title}") if title != ''
        # end

        # def h3(title)
        #   write_line("### #{title}") if title != ''
        # end

        # def h4(title)
        #   write_line("#### #{title}") if title != ''
        # end

        # def h5(title)
        #   write_line("##### #{title}") if title != ''
        # end

        # def h6(title)
        #   write_line("###### #{title}") if title != ''
        # end

        def block_quotes(value)
          write_line("> #{value}") if value != ''
        end

        def bullet(value)
          write_line("- #{value}") if value != ''
        end

        def hr
          write_line '---'
        end
      end
    end
  end
end
