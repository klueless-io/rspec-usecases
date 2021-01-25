# frozen_string_literal: true

module Rspec
  module Usecases
    module Helpers
      # Grab lines from content into lines array and then extract specific lines
      #
      # Note that this is a 1 based index, instead of a traditional zero based index
      #
      # An array of [to, from] can be passed to grab specific lines
      # from the content
      #
      # content = <<~TEXT.strip
      #                 line 1
      #                 line 2
      #           #{'      '}
      #                 line 4
      #                 line 5
      #           TEXT
      #
      # @example - grab specific line numbers
      #
      #   lines = uc_grab_lines(content, [1, 3, 5])
      #   it { lines.to match_array(['line 1', '', 'line 5']) }
      #
      # @example - specific and range of line numbers
      #
      #   lines = uc_grab_lines(content, [1, *(3..4), 5])
      #   it { lines.to match_array(['line 1', '', 'line 4', 'line 5']) }
      #
      # @raise [Rspec::Usecases::Error] if lines to include contains a value less than 1
      # @raise [Rspec::Usecases::Error] if lines to include contains a value greater than the content.line_count
      #
      # @param [Array<Integer>] lines_to_include is a list of line numbers to pluck from string
      def uc_grab_lines(content, lines_to_include)
        content_lines = content.lines

        line_nos = lines_to_include.sort.collect

        raise(Rspec::Usecases::Error, 'Line numbers must start from 1') if line_nos.min < 1

        raise(Rspec::Usecases::Error, "Line number out of range - content_length: #{content_lines.length} - line_no: #{line_nos.max}") if
          content_lines.length <= line_nos.max - 1

        output_lines = line_nos.map { |line_no| content_lines[line_no - 1].chomp }

        output_lines.join("\n")
      end
    end
  end
end
