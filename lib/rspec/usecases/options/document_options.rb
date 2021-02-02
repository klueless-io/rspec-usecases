# frozen_string_literal: true

module Rspec
  module Usecases
    module Options
      # Document Options
      class DocumentOptions
        attr_reader :json
        attr_reader :debug
        attr_reader :markdown

        def initialize(config)
          @json = Rspec::Usecases::Options::JsonOptions.new(config[:json])
          @debug = Rspec::Usecases::Options::DebugOptions.new(config[:debug])
          @markdown = Rspec::Usecases::Options::MarkdownOptions.new(config[:markdown])
        end

        def to_h
          Rspec::Usecases::Options::DynamicOptions.struct_to_hash(OpenStruct.new(json: json, debug: debug, markdown: markdown))
        end
      end
    end
  end
end
