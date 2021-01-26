# frozen_string_literal: true

# require 'rspec/usecases/usecase'

module Rspec
  module Usecases
    # A usecase stores documentation for a single code usage scenario.
    class Usecase
      # key
      attr_reader :key

      # title
      attr_reader :title

      # deep title is constructed by concatenating the chain of parents titles
      attr_reader :deep_title

      # summary
      attr_reader :summary

      # Usage contains a sample on how to call some code
      attr_reader :usage

      # Usage description gives extra details to support the usage example
      attr_reader :usage_description

      # contents
      attr_reader :contents

      def initialize(key)
        @key = key
        @title = ''
        @deep_title = ''
        @summary = ''
        @usage = ''
        @usage_description = ''
        @contents = []
      end

      def self.parse(key, data)
        usecase = Usecase.new(key)

        usecase.build_title(data)
        usecase.build_attributes(data)

        # Loop through the it blocks
        data.examples.each do |it|
          usecase.add_content(it)
        end

        usecase
      end

      def to_h
        {
          key: key,
          title: title,
          deep_title: deep_title,
          summary: summary,
          usage: usage,
          usage_description: usage_description,
          contents: contents.map(&:to_h)
        }
      end

      def debug
        puts "key                           : #{key}"
        puts "title                         : #{title}"
        puts "deep_title                    : #{deep_title}"
        puts "summary                       : #{summary}"
        puts "usage                         : #{usage}"
        puts "usage_description             : #{usage_description}"
        puts "contents                      : #{contents}"
      end

      def add_content(example)
        content = Rspec::Usecases::Content.parse(example)
        @contents << content unless content.nil?
      end

      def build_attributes(example_group)
        @summary = example_group.metadata[:summary] if example_group.metadata[:summary]

        @usage = example_group.metadata[:usage] if example_group.metadata[:usage]
        @usage_description = example_group.metadata[:usage_description] if example_group.metadata[:usage_description]
      end

      # Build the title from the rspec example_group, aka describe or context
      #
      # If title attribute is set then this takes priority.
      # If not set, then build the title by looking through the parent objects
      def build_title(example_group)
        return if title != ''

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
