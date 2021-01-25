# frozen_string_literal: true

module Rspec
  module Usecases
    module Helpers
      # Builds markdown ```content block``` by injecting content
      # from an existing file.
      #
      # @param [String] filename to read content from
      # @param [Array<Integer>] lines (optional) - specific list of line numbers to grab using a 1 based index
      # @param [String] code_type (optional) - what type of content is this, eg. javascript, ruby, css
      def uc_file_as_markdown_content(filename, lines: nil, code_type: nil)
        content = File.read(filename)
  
        content = uc_grab_lines(content, lines) if lines
  
        # To Deprecate: It may not be smart to support the code_type arg
        #               it is probably better to pass content into markdown 
        #               components in raw format and let them apply this value
        content = "```#{code_type}\n#{content}\n```" unless code_type.nil?
        content
      end
    end
  end
end
