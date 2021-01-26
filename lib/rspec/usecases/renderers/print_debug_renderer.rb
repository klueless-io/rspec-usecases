# frozen_string_literal: true

require 'rspec/usecases/renderers/base_renderer'

module Rspec
  module Usecases
    # Renderers write out meta data in various output formats. JSON, Debug, Markdown etc.
    module Renderers
      # Print Debug Renderer
      class PrintDebugRenderer < Rspec::Usecases::Renderers::BaseRenderer
        def render
          print_document_header
          document.usecases.each { |usecase| print_usecase(usecase) }
          puts @output
        end

        private

        def print_document_header
          write_line '*' * 100
          write_line "Title             : #{document.title}" if document.title
          write_line "Description       : #{document.description}" if document.description
        end

        def print_usecase(usecase)
          print_usecase_header(usecase)

          usecase.contents.each { |content| print_usecase_content(content) }
        end

        def print_usecase_header(usecase)
          write_line '=' * 100
          write_line "Key               : #{usecase.key}" if usecase.key
          write_line "Title             : #{usecase.title}" if usecase.title
          write_line "Usage             : #{usecase.usage}" if usecase.usage
          write_line "Usage Description : #{usecase.usage_description}" if usecase.usage_description
        end

        # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
        def print_usecase_content(content)
          write_line '-' * 100
          write_line "Title             : #{content.title}" if content.title != ''
          write_line "Type              : #{content.type}" if content.type != ''

          # Used by outcome
          write_line "Summary           : #{content.summary}" if content.respond_to?('summary') && content.summary != ''

          # Used by code
          write_line "Code              : #{content.code}" if content.respond_to?('code') && content.code != ''
          write_line "Code Type         : #{content.code_type}" if content.respond_to?('code_type') && content.code_type != ''
          write_line content.source if content.respond_to?('source') && content.source != ''
        end
        # rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
      end
    end
  end
end
