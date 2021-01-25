# frozen_string_literal: true

require 'rspec/usecases/version'
require 'rspec/usecases/usecase'
require 'rspec/usecases/content'
require 'rspec/usecases/content_code'
require 'rspec/usecases/content_outcome'
require 'rspec/usecases/document'
require 'rspec/usecases/renderers/base_renderer'
require 'rspec/usecases/renderers/print_debug_renderer'

module Rspec
  module Usecases
    # raise Rspec::Usecases::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end
