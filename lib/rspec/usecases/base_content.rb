# frozen_string_literal: true

# require 'rspec/usecases/content'

module Rspec
  module Usecases
    # BaseContent
    class BaseContent
      METHOD_NAMES = %w[outcome code ruby css js javascript].join('|').freeze
      EXTRACT_CONTENT_REX = /
        (?<bos>^)                             # beginning of string
        (?<indent>\s*)                        # find the indent before the method
        (?<method_type>#{METHOD_NAMES})\s     # grab the method name from predefined list
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
        # return nil if example.description.nil?# || example.description.strip.length.zero?
        return nil if example.metadata[:content_type].nil?

        result = get_instance(example)

        result&.parse_block_source(example)

        result
      end

      # rubocop:disable Lint/UselessAssignment, Security/Eval
      def self.get_instance(example)
        title = example.description.strip
        type = example.metadata[:content_type].to_s
        metadata = example.metadata

        klass = "Rspec::Usecases::Content#{type.capitalize}"

        begin
          content_object = "#{klass}.parse(title, type, metadata)"
          eval(content_object)
        rescue NameError
          # TODO: Logging
          puts "UNKNOWN CONTENT TYPE: #{type}"
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

        # May want to delegate this to an OpenStruct called options
        @is_hr = !!metadata[:hr]

        yield self if block_given?
      end

      # Source code for rspec is living on the metadata[:block].source location
      # Have not written a test for this yet
      def parse_block_source(example)
        unless example.metadata[:source_override].nil?
          @source = example.metadata[:source_override]
          return
        end

        source = get_source(example)

        # NOTE: Need to investigate how RSpec deals with code, see:
        # https://github.com/rspec/rspec-core/blob/fe3084758857f0714f05ada44a18f1dfe9bf7a7e/spec/rspec/core/formatters/snippet_extractor_spec.rb
        # https://github.com/rspec/rspec-core/blob/fe3084758857f0714f05ada44a18f1dfe9bf7a7e/lib/rspec/core/formatters/html_formatter.rb
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

      def get_source(example)
        if defined?(example.metadata) && defined?(example.metadata[:block]) && defined?(example.metadata[:block].source)
          example.metadata[:block].source.strip
        else
          ''
        end
      end

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
          is_hr: is_hr
          # options: [
          #   is_hr: is_hr
          # ]
        }
      end
    end
  end
end