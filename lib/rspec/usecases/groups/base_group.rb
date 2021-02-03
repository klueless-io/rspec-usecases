# frozen_string_literal: true

module Rspec
  module Usecases
    module Groups
      # Base Group
      class BaseGroup
        # key
        attr_reader :key

        # type of group
        attr_reader :type

        # title
        attr_reader :title

        # deep title is constructed by concatenating the chain of parents titles
        # investigate the existing full_title attribute already on example_group
        attr_reader :deep_title

        # summary
        attr_reader :summary

        # contents
        attr_reader :contents

        # Nested groups, this is helpful when grouping
        attr_accessor :groups

        def initialize(key, type, example_group)
          @key = key
          @type = type
          @deep_title = ''
          @groups = []

          build_title(example_group)
          build_attributes(example_group)

          # Loop through the it blocks
          @contents = example_group.examples.map { |example| parse_content(example) }
        end

        def self.parse(key, example_group)
          # return nil if example_group.description.nil?# || example_group.description.strip.length.zero?
          return nil if example_group.metadata[:group_type].nil?

          get_instance(key, example_group)
        end

        def self.get_instance(key, example_group)
          type = example_group.metadata[:group_type].to_s

          begin
            klass = Module.const_get("Rspec::Usecases::Groups::#{type.capitalize}")
            klass.new(key, type, example_group)
          rescue NameError
            # TODO: Logging
            puts "UNKNOWN GROUP TYPE: #{type}"
            nil
          rescue StandardError => e
            # TODO: Logging
            puts e
            nil
          end
        end

        def to_h
          {
            key: key,
            title: title,
            deep_title: deep_title,
            summary: summary,
            contents: contents.map(&:to_h),
            groups: groups.map(&:to_h)
          }
        end

        # Override in child instances for class specific attributes
        def build_attributes(example_group)
          @summary = example_group.metadata[:summary] || ''
        end

        private

        def parse_content(example)
          Rspec::Usecases::Contents::BaseContent.parse(example)
        end

        # Build the title from the rspec example_group, aka describe or context
        #
        # If title attribute is set then this takes priority.
        # If not set, then build the title by looking through the parent objects
        def build_title(example_group)
          # return if title != ''

          @title = example_group.metadata[:title] || example_group.description
          # .example_group.parent_groups.first&.description

          build_deep_title(example_group)
        end

        def build_deep_title(example_group)
          # example_group.parent_groups.reverse[0..-2].map { |g| g.description }
          example_group.parent_groups.reverse[0..-2].each do |group|
            @deep_title = if @deep_title.length.zero?
                            group.description
                          else
                            "#{@deep_title} #{group.description}"
                          end
          end
          @deep_title = "#{@deep_title} #{@title}"
        end
      end
    end
  end
end
