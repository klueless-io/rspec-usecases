# frozen_string_literal: true

module Rspec
  module Usecases
    # A document represents a list of usecases
    #
    # A document can have a title, description and a list of usecases
    # A usecase is just an Rspec context or describe block with the
    # attribute usecase set to true - usecase: true
    class Document
      attr_reader :title
      attr_reader :description
      attr_reader :usecases

      attr_reader :markdown_file

      def initialize(root_example_group)
        @root = root_example_group

        parse_metadata

        build_usecases
      end

      def to_h
        {
          settings: {
            json: json?,
            debug: debug?,
            markdown: markdown?,
            markdown_file: markdown_file,
            markdown_prettier: markdown_prettier?,
            markdown_open: markdown_open?
          },
          title: title,
          description: description,
          usecases: usecases.map(&:to_h)
        }
      end

      def json?
        @json
      end

      def debug?
        @debug
      end

      def markdown?
        @markdown
      end

      def markdown_prettier?
        @markdown_prettier
      end

      def markdown_open?
        @markdown_open
      end

      private

      # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
      def parse_metadata
        # TODO: Extract out a document settings class
        # General Settings
        @json = !!@root.metadata[:json] && @root.metadata[:json] == true
        @debug = !!@root.metadata[:debug] && @root.metadata[:debug] == true
        @markdown = !!@root.metadata[:markdown] && @root.metadata[:markdown] == true

        # Markdown Settings
        @markdown_file = @root.metadata[:markdown_file] || 'generate_markdown.md'
        @markdown_prettier = @root.metadata[:markdown_prettier] || false
        @markdown_open = @root.metadata[:markdown_open] || false

        # Document data
        @title = @root.metadata[:document_title] || ''
        @description = @root.metadata[:document_description] || ''
      end
      # rubocop:enable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

      def build_usecases
        @usecases = []

        # This is a documentor setting
        return unless @root.metadata[:usecases]

        # Get a list of describe or context blocks with the :usecase
        # metadata flag, or use `usecase 'xyz' do end` in your code.
        usecases = @root.descendants.select { |d| d.metadata[:usecase] == true }

        @usecases = usecases.map { |usecase| Rspec::Usecases::Usecase.parse(usecase.name, usecase) }
      end
    end
  end
end
