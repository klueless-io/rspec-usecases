# frozen_string_literal: true

module Rspec
  module Usecases
    # Content Code
    class ContentCode < Rspec::Usecases::BaseContent
      # # Source code
      # attr_accessor :code

      # Type of code, ruby, javascript, css etc.
      attr_accessor :code_type

      # Note
      attr_accessor :note

      def self.parse(title, type, metadata)
        new(title, type, metadata) do |content|
          # content.code = metadata[:code].to_s
          content.code_type = metadata[:code_type].to_s
          content.note = metadata[:note].to_s
        end
      end

      def to_h
        {
          code_type: code_type,
          note: note
        }.merge(super.to_h)
      end
    end
  end
end
