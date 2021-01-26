# frozen_string_literal: true

module Rspec
  module Usecases
    # Documentor
    class Documentor
      # Document that is to be rendered
      attr_reader :document

      # List of renderers selected for rendering
      attr_reader :renderers

      def initialize(root)
        @document = Rspec::Usecases::Document.new(root)

        build_renderers
      end

      def render
        @renderers.each(&:render)
      end

      private

      def build_renderers
        @renderers = []
        @renderers << Rspec::Usecases::Renderers::PrintJsonRenderer.new(document) if document.json?
        @renderers << Rspec::Usecases::Renderers::PrintDebugRenderer.new(document) if document.debug?
        @renderers << Rspec::Usecases::Renderers::GenerateMarkdownRenderer.new(document) if document.markdown?
      end
    end
  end
end
