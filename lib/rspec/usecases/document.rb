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

      def initialize(root_example_group, **options)
        @root = root_example_group
        @options = if options.nil? || options.empty?
                     Rspec::Usecases::Options::DocumentOptions.new(@root.metadata)
                   else
                     Rspec::Usecases::Options::DocumentOptions.new(options)
                   end

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

      def to_h
        {
          settings: {
            json: json?,
            debug: debug?,
            markdown: markdown?,
            markdown_file: markdown_file,
            markdown_prettier: markdown_prettier?,
            markdown_open: markdown_open?,
            skip_render: skip_render?
          },
          title: title,
          description: description,
          groups: groups.map(&:to_h)
        }
      end

      private

      # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
      def value_to_type(value, default_value: :detail, fail_value: :skip)
        if value.nil?
          [fail_value]
        elsif !!value == value
          value ? [default_value] : [fail_value]
        elsif value.is_a?(String)
          [value.to_sym]
        elsif value.is_a?(Symbol)
          [value]
        elsif value.is_a?(Array)
          value.map do |v|
            case value
            when Symbol
              v
            when String
              v.to_sym
            when !!value
              value ? default_value : fail_value
            else
              raise Rspec::Usecases::Error, 'Unknown option paramater'
            end
          end
        else
          raise Rspec::Usecases::Error, 'Unknown option paramater'
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize

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

      # rubocop:disable Metrics/AbcSize
      def flatten_group_hierarchy(example_group, level)
        # puts "name            : #{example_group.name}"
        # puts "entering level  : #{level}"
        # if example_group.metadata[:usecase] == true
        #   group = Rspec::Usecases::Groups::Usecase.parse(example_group.name, example_group)
        #   return [group]
        # end

        # { name: example_group.name, is_group: example_group.metadata[:group], child_count: example_group.children.length }
        # { name: child_example_group.name, is_group: child_example_group.metadata[:group], child_count: child_example_group.children.length }
        level_groups = []

        example_group.children.each do |child_example_group|
          if child_example_group.metadata[:usecase] == true
            raise(Rspec::Usecases::Error, 'Group required') if child_example_group.metadata[:group_type].nil?

            group = Rspec::Usecases::Groups::BaseGroup.parse(child_example_group.name, child_example_group)

            child_groups = flatten_group_hierarchy(child_example_group, level + 1)

            group.groups = child_groups

            groups.push group

            level_groups.push group
          else
            # puts 'keep looking'
            sibling_groups = flatten_group_hierarchy(child_example_group, level)

            # puts "level            : #{level}"
            # puts "level_groups   : #{level_groups.length}"
            # puts "sibling_groups : #{sibling_groups.length}"

            level_groups += sibling_groups
          end
        end

        # puts "leaving level   : #{level}"
        # puts "count for level : #{level_groups.length}"

        level_groups
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end
