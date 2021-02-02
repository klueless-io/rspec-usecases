# frozen_string_literal: true

require 'rspec/usecases/version'
require 'rspec/usecases/usecase'
require 'rspec/usecases/configure'
require 'rspec/usecases/base_content'
require 'rspec/usecases/content_code'
require 'rspec/usecases/content_outcome'
require 'rspec/usecases/document'
require 'rspec/usecases/documentor'
require 'rspec/usecases/generator/base_generator'
require 'rspec/usecases/generator/json_generator'
require 'rspec/usecases/generator/debug_generator'
require 'rspec/usecases/generator/markdown_generator'
require 'rspec/usecases/helpers/uc_file_as_markdown_content'
require 'rspec/usecases/helpers/uc_grab_lines'
require 'rspec/usecases/options/dynamic_options'
require 'rspec/usecases/options/document_options'
require 'rspec/usecases/options/debug_options'
require 'rspec/usecases/options/markdown_options'
require 'rspec/usecases/options/json_options'

module Rspec
  module Usecases
    # raise Rspec::Usecases::Error, 'Sample message'
    class Error < StandardError; end

    # Your code goes here...
  end
end
