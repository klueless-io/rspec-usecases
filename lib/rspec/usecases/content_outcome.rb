# frozen_string_literal: true

module Rspec
  module Usecases
    # Content Outcome
    class ContentOutcome < Rspec::Usecases::BaseContent
      # Note, similar to summary on usecase, but due to
      # metadata inheritance, I needed to use a different
      # property name
      attr_accessor :note

      def self.parse(title, type, metadata)
        new(title, type, metadata) do |content|
          content.note = metadata[:note].to_s
        end
      end

      def to_h
        {
          note: note
        }.merge(super.to_h)
      end

      def debug(format: :detail)
        super(format: format)

        return unless format == :detail

        puts "note                          : #{note}"
      end
    end
  end
end
