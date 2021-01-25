# frozen_string_literal: true

require 'json'

module Rspec
  module Usecases
    module Renderers
      # Print JSON Renderer
      class PrintJsonRenderer
        def render(document)
          puts JSON.pretty_generate({
                                      document: {
                                        title: document.title,
                                        description: document.description
                                      },
                                      usecases: document.usecases.map(&:to_h)
                                    })
        end
      end
    end
  end
end
