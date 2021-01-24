# frozen_string_literal: true

require 'rspec/usecases/content'

module Rspec
  module Usecases
    # Content Outcome
    class ContentOutcome < Rspec::Usecases::Content
      # Summary
      attr_accessor :summary

      def self.parse(title, type, metadata)
        new(title, type, metadata) do |content|
          content.summary = metadata[:summary].to_s
        end
      end

      def to_h
        {
          summary: summary
        }.merge(super.to_h)
      end

      def debug
        super
        puts "summary                       : #{summary}"
      end
    end
  end
end
