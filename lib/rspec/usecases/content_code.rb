# frozen_string_literal: true

require 'rspec/usecases/content'

module Rspec
  module Usecases
    # Content Code
    class ContentCode < Rspec::Usecases::Content
      # Source code
      attr_accessor :code

      # Type of code, ruby, javascript, css etc.
      attr_accessor :code_type

      # Summary
      attr_accessor :summary

      def self.parse(title, type, metadata)
        new(title, type, metadata) do |content|
          content.code = metadata[:code].to_s
          content.code_type = metadata[:code_type].to_s
          content.summary = metadata[:summary].to_s
        end
      end

      def to_h
        {
          code: code,
          code_type: code_type,
          summary: summary
        }.merge(super.to_h)
      end

      def debug
        super
        puts "code                          : #{code}"
        puts "code_type                     : #{code_type}"
        puts "summary                       : #{summary}"
      end
    end
  end
end
