# frozen_string_literal: true

require 'json'
require 'rspec/usecases/renderers/base_renderer'

module Rspec
  module Usecases
    module Renderers
      # Print JSON Renderer
      class PrintJsonRenderer < Rspec::Usecases::Renderers::BaseRenderer
        def render
          data = {
            document: {
              title: document.title,
              description: document.description
            },
            usecases: document.usecases.map(&:to_h)
          }
          puts JSON.pretty_generate(data)
        end
      end
    end
  end
end
