# frozen_string_literal: true

module Rspec
  module Usecases
    # A document represents a list of groups, the main group type being usecases
    #
    # A document can have a title, description and a list of groups
    # A group is just an Rspec context or describe block with the
    # attribute usecase set to true - usecase: true
    #
    # The list of groups can have their own child list of
    # groups that can go down to any practical depth.
    class Document
      attr_reader :title
      attr_reader :description
      attr_reader :groups
      attr_reader :options

      attr_reader :lookup_content

      def initialize(root_example_group, **options)
        @root = root_example_group
        options = @root.metadata if options.nil? || options.empty?
        @options = Rspec::Usecases::Options::DocumentOptions.new(options)

        @lookup_content = {}
        @lookup_content_keys = []

        parse_title_description
        build_groups
      end

      def json?
        options.json.active?
      end

      def debug?
        options.debug.active?
      end

      def markdown?
        options.markdown.active?
      end

      def skip_render?
        @skip_render
      end

      # TODO: This is the old format, needs refactor
      def to_h
        {
          settings: {
            # json: json?,
            # debug: debug?,
            # markdown: markdown?,
            # markdown_file: markdown_file,
            # markdown_prettier: markdown_prettier?,
            # markdown_open: markdown_open?,
            # skip_render: skip_render?
          },
          title: title,
          description: description,
          groups: groups.map(&:to_h)
        }
      end

      def after_context
        @lookup_content_keys.each do |key|
          content = lookup_content[key]
          content.after_context(self)
        end
      end

      private

      def extract_meta_options
        {
          json: @root.metadata[:json],
          debug: @root.metadata[:debug],
          markdown: @root.metadata[:markdown],
          document_title: @root.metadata[:document_title],
          document_description: @root.metadata[:document_description]
        }
      end

      def parse_title_description
        @skip_render = !!@root.metadata[:skip_render] && @root.metadata[:skip_render] == true

        # # Document data
        @title = @root.metadata[:document_title] || ''
        @description = @root.metadata[:document_description] || ''
      end

      def build_groups
        @groups = []

        # This is a documentor setting
        return unless @root.metadata[:usecases]

        # Get a list of describe or context blocks with the :usecase
        # metadata flag, or use `usecase 'xyz' do end` in your code.
        @groups = flatten_group_hierarchy(@root, 1)

        # debug
      end

      def flatten_group_hierarchy(example_group, level)
        level_groups = []

        example_group.children.each do |child_example_group|
          if child_example_group.metadata[:usecase] == true
            raise(Rspec::Usecases::Error, 'Group required') if child_example_group.metadata[:group_type].nil?

            group = build_group(child_example_group, level)

            add_each_content_to_lookup(group)

            group.groups = flatten_group_hierarchy(child_example_group, level + 1)

            level_groups.push group
          else
            # puts 'keep looking'
            sibling_groups = flatten_group_hierarchy(child_example_group, level)

            level_groups += sibling_groups
          end
        end

        # puts "leaving level   : #{level}"
        # puts "count for level : #{level_groups.length}"

        level_groups
      end

      def build_group(child_example_group, level)
        group = Rspec::Usecases::Groups::BaseGroup.parse(child_example_group.name, child_example_group)
        group.hierarchy_level = level
        group.heading_level = level + 1
        group
      end

      def add_each_content_to_lookup(group)
        group.contents.each do |content|
          @lookup_content[content.id] = content
          @lookup_content_keys << content.id
        end
      end
    end
  end
end
