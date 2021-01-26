# frozen_string_literal: true

require 'forwardable'

module Rspec
  module Usecases
    module Renderers
      # Generate Markdown Renderer
      class GenerateMarkdownRenderer < Rspec::Usecases::Renderers::BaseRenderer
        extend Forwardable

        def_delegators :@document, :markdown_file, :markdown_prettier?, :markdown_open?

        def render
          render_header

          document.usecases.each { |usecase| print_usecase(usecase) }

          write_file(markdown_file)
          prettier_file(markdown_file) if markdown_prettier?
          open_file_in_vscode(markdown_file) if markdown_open?

          # puts @output
          # puts markdown_file
          # system "code #{file}"
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

        def render_header
          h1 document.title
          write_line document.description
          write_lf
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
        end

        def render_outcome(content)
          bullet content.title
          write_line content.summary if content.summary
        end

        def render_code(content)
          h4 content.title
          write_line content.summary if content.summary
          render_code_block(content.source, content.code_type) unless content.source == ''
        end

        def render_code_block(source, code_type)
          write_line "```#{code_type}"
          write_line source
          write_line '```'
        end
      end
    end
  end
end
