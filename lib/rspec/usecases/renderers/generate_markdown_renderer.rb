# frozen_string_literal: true

# require 'rspec/usecases/renderers/generate_markdown_renderer'

module Rspec
  module Usecases
    module Renderers
      # Generate Markdown Renderer
      class GenerateMarkdownRenderer < Rspec::Usecases::Renderers::BaseRenderer
        attr_reader :file
        attr_reader :prettier
        attr_reader :open

        def initialize(metadata)
          super()
          @file = metadata[:markdown_file] || 'generate_markdown.md'
          @prettier = metadata[:markdown_prettier] || false
          @open = metadata[:markdown_open] || false
        end

        def render(document)
          h1 document.title
          write_line document.description
          write_lf

          document.usecases.each { |usecase| print_usecase(usecase) }

          write_file(file)
          prettier_file(file) if prettier
          open_file_in_vscode(file) if open

          puts @output
          puts file
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

        def print_usecase(usecase)
          h2 usecase.title
          write_lf
          if usecase.summary
            write_line usecase.summary
            write_lf
          end

          unless usecase.usage == ''
            # h3 'Usage'
            h3 usecase.usage
            write_lf
            if usecase.usage_description
              write_line usecase.usage_description
              write_lf
            end
          end

          if usecase.contents.length.positive?

            usecase.contents.each do |content|
              write_line '---' if content.is_hr

              render_outcome(content) if content.type == 'outcome'
              render_code(content) if content.type == 'code'
            end
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
