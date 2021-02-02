# frozen_string_literal: true

module Rspec
  module Usecases
    # Documentor
    class Documentor
      # Document that is to be rendered
      attr_reader :document

      # List of generators selected for rendering
      attr_reader :generators

      def initialize(root)
        @document = Rspec::Usecases::Document.new(root)

        build_generators
      end

      def render
        @generators.each(&:run)
      end

      private

      # rubocop:disable Metrics/AbcSize
      def build_generators
        @generators = []
        @generators << Rspec::Usecases::Generator::JsonGenerator.new(document, document.options.json) if document.json?
        @generators << Rspec::Usecases::Generator::DebugGenerator.new(document, document.options.debug) if document.debug?
        @generators << Rspec::Usecases::Generator::MarkdownGenerator.new(document, document.options.markdown) if document.markdown?
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
