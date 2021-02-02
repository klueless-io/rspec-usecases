# frozen_string_literal: true

module Rspec
  module Usecases
    # A document represents a list of usecases
    #
    # A document can have a title, description and a list of usecases
    # A usecase is just an Rspec context or describe block with the
    # attribute usecase set to true - usecase: true
    #
    # The list of usecases can have their own child list of
    # usecases that can go down to any practical depth.
    class Document
      attr_reader :title
      attr_reader :description
      attr_reader :usecases
      attr_reader :options

      # attr_reader :json
      # attr_reader :debug
      # attr_reader :markdown
      # attr_reader :markdown_file

      def initialize(root_example_group, **options)
        @root = root_example_group
        @options = if options.nil? || options.empty?
                     Rspec::Usecases::Options::DocumentOptions.new(@root.metadata)
                   #  extract_meta_options
                   else
                     Rspec::Usecases::Options::DocumentOptions.new(options)
                   end

        parse_title_description
        build_usecases
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
          usecases: usecases.map(&:to_h)
        }
      end

      def debug
        puts "json               : #{@json}"
        puts "debug              : #{@debug}"
        puts "markdown           : #{@markdown}"
        puts "markdown_file      : #{@markdown_file}"
        puts "markdown_prettier  : #{@markdown_prettier}"
        puts "markdown_open      : #{@markdown_open}"
        puts "title              : #{@title}"
        puts "description        : #{@description}"

        usecases.each_with_index do |u, i|
          if i.zero?
            puts '-[ Usecases ] --------------------------------------------------------'
          else
            puts '----------------------------------------------------------------------'
          end
          u.debug(format: :simple)
        end
      end

      private

      # rubocop:disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/AbcSize
      def value_to_type(value, default_value: :detail, fail_value: :skip)
        # puts value
        # puts default_value
        # puts fail_value
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

      def build_usecases
        @usecases = []

        # This is a documentor setting
        return unless @root.metadata[:usecases]

        # Get a list of describe or context blocks with the :usecase
        # metadata flag, or use `usecase 'xyz' do end` in your code.
        @usecases = flatten_usecase_hierarchy(@root, 1)

        # debug
      end

      def flatten_usecase_hierarchy(example_group, level)
        # puts "name            : #{example_group.name}"
        # puts "entering level  : #{level}"
        # if example_group.metadata[:usecase] == true
        #   usecase = Rspec::Usecases::Usecase.parse(example_group.name, example_group)
        #   return [usecase]
        # end

        # { name: example_group.name, is_usecase: example_group.metadata[:usecase], child_count: example_group.children.length }
        # { name: child_example_group.name, is_usecase: child_example_group.metadata[:usecase], child_count: child_example_group.children.length }
        level_usecases = []

        example_group.children.each do |child_example_group|
          if child_example_group.metadata[:usecase] == true
            # puts 'use case found'
            usecase = Rspec::Usecases::Usecase.parse(child_example_group.name, child_example_group)

            child_usecases = flatten_usecase_hierarchy(child_example_group, level + 1)
            # puts "child_usecases  : #{child_usecases.length}"

            usecase.usecases = child_usecases

            usecases.push usecase

            level_usecases.push usecase
          else
            # puts 'keep looking'
            sibling_usecases = flatten_usecase_hierarchy(child_example_group, level)

            # puts "level            : #{level}"
            # puts "level_usecases   : #{level_usecases.length}"
            # puts "sibling_usecases : #{sibling_usecases.length}"

            level_usecases += sibling_usecases
          end
        end

        # puts "leaving level   : #{level}"
        # puts "count for level : #{level_usecases.length}"

        level_usecases
      end
    end
  end
end
