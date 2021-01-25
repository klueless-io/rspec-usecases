# frozen_string_literal: true

# require 'rspec/usecases/content'

module Rspec
  module Usecases
    # Content
    class Content
      EXTRACT_CONTENT_REX = /
        (?<bos>^)                             # beginning of string
        (?<indent>\s*)                        # find the indent before the method
        (?<method_type>outcome|code|ruby)\s   # grab the method name from predefined list
        (?<method_signature>.*?)              # grab the method signature which is every thing up to the first do
        (?<method_open>do)                    # code comes after the first do
        (?<content>.*)                        # content is what we want
        (?<method_closure>end)\z              # the end keyword at the end of string is where the content finishes
      /xm.freeze

      # title
      attr_accessor :title

      # :type
      attr_accessor :type

      # metadata
      attr_accessor :metadata

      # source
      attr_accessor :source

      # is_hr
      attr_accessor :is_hr

      def self.parse(example)
        return nil if example.description.nil? || example.description.strip.length.zero?
        return nil if example.metadata[:content_type].nil?

        result = get_instance(example)

        result&.parse_block_source(example)

        result
      end

      # rubocop:disable Lint/UselessAssignment, Security/Eval
      def self.get_instance(example)
        title = example.description
        type = example.metadata[:content_type].to_s
        metadata = example.metadata

        klass = "Rspec::Usecases::Content#{type.capitalize}"

        begin
          content_object = "#{klass}.parse(title, type, metadata)"
          eval(content_object)
        rescue NameError
          # TODO: Logging
          puts "UNKNOWN CONTENT TYPE: #{metadata[:content_type]}"
          nil
        rescue StandardError => e
          # TODO: Logging
          puts e
          nil
        end
      end
      # rubocop:enable Lint/UselessAssignment, Security/Eval

      def initialize(title, type, metadata)
        @title = title.start_with?('example at .') ? '' : title
        @type = type

        @is_hr = !!metadata[:hr]

        yield self if block_given?
      end

      # Have not written a test for this yet
      # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize
      def parse_block_source(example)
        @debug = false

        # Source code for rspec is living on the metadata[:block].source location
        unless defined?(example.metadata) && defined?(example.metadata[:block]) && defined?(example.metadata[:block].source)
          @source = ''
          return
        end

        unless example.metadata[:source_override].nil?
          @source = example.metadata[:source_override]
          return
        end

        source = example.metadata[:block].source.strip

        segments = source.match(EXTRACT_CONTENT_REX)

        unless defined?(segments) && defined?(segments[:content])
          @source = ''
          return
        end
        @source = remove_wasted_indentation(segments[:content])
        @source
      rescue StandardError => e
        puts 'Could not parse source'
        puts example.metadata
        puts e
      end
      # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize

      def remove_wasted_indentation(content)
        lines = content.lines

        whitespace = /^\s*/

        # find the small whitespace sequence
        # at beginning of line that is not \n or blank
        # and grab the smallest value
        indent = lines
                 .map    { |l| l.match(whitespace).to_s }
                 .reject { |s| ["\n", ''].include?(s) }
                 .min_by(&:length)

        # remove the smallest indentation from beginning
        # of all lines, this is the wasted indentation
        rex_indent = /^#{indent}/

        lines.each { |l| l.gsub!(rex_indent, '') }

        # convert back to a content string
        lines.join.strip
      end

      def to_h
        {
          title: title,
          type: type,
          source: source,
          options: [
            is_hr: is_hr
          ]
        }
      end

      def debug
        puts "title                         : #{title}"
        puts "type                          : #{type}"
        puts "metadata                      : #{metadata}"
        puts "source                        : #{source}"
        puts "is_hr                         : #{is_hr}"
      end
    end
  end
end
