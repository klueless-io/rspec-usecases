# frozen_string_literal: true

module Rspec
  module Usecases
    # Documentor
    class Documentor
      # Document that is to be rendered
      attr_reader :document

      # List of renderers selected for rendering
      attr_reader :renderers

      def json?
        @json
      end

      def debug?
        @debug
      end

      def markdown?
        @markdown
      end

      # Generate Markdown Renderer
      attr_reader :render_generate_markdown

      def initialize(root_example_group)
        @root = root_example_group

        build_settings
        build_renderers

        @document = Rspec::Usecases::Document.new(@root)
      end

      def render
        @renderers.each do |renderer|
          renderer.render(document)
        end
      end

      private

      # rubocop:disable Metrics/AbcSize
      def build_settings
        @json = !!@root.metadata[:json] && @root.metadata[:json] == true
        @debug = !!@root.metadata[:debug] && @root.metadata[:debug] == true
        @markdown = !!@root.metadata[:markdown] && @root.metadata[:markdown] == true
      end
      # rubocop:enable Metrics/AbcSize

      def build_renderers
        @renderers = []
        @renderers << Rspec::Usecases::Renderers::PrintJsonRenderer.new if json?
        @renderers << Rspec::Usecases::Renderers::PrintDebugRenderer.new if debug?
        @renderers << Rspec::Usecases::Renderers::GenerateMarkdownRenderer.new if markdown?
      end

      # def debug
      #   puts "renderers                     : #{renderers}"
      #   puts "render_json                   : #{render_json}"
      #   puts "render_debug                  : #{render_debug}"
      #   puts "render_generate_markdown      : #{render_generate_markdown}"
      # end
    end
  end
end
