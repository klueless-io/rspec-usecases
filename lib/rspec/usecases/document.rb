# frozen_string_literal: true

module Rspec
  module Usecases
    # A document represents a list of usecases
    #
    # A document can have a title, description and a list of usecases
    # A usecase is just an Rspec context or describe block with the
    # attribute usecase set to true - usecase: true
    class Document
      attr_reader :usecases

      attr_reader :title
      attr_reader :description

      def initialize(root_example_group)
        @root = root_example_group

        build_settings

        build_usecases
      end

      def to_h
        {
          title: title,
          description: description,
          usecases: usecases.map(&:to_h)
        }
      end

      private

      def build_settings
        @title = @root.metadata[:document_title] || ''
        @description = @root.metadata[:document_description] || ''
      end

      def build_usecases
        @usecases = []

        # This is a documentor setting
        return unless @root.metadata[:usecases]

        # Get a list of describe or context blocks with the :usecase
        # metadata flag, or use `usecase 'xyz' do end` in your code.
        usecases = @root.descendants.select { |d| d.metadata[:usecase] == true }

        @usecases = usecases.map { |usecase| Rspec::Usecases::Usecase.parse(usecase.name, usecase) }
      end
    end
  end
end
