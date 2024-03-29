# frozen_string_literal: true

require 'rspec/usecases/version'
require 'rspec/usecases/configure'
require 'rspec/usecases/contents/base_content'
require 'rspec/usecases/contents/code'
require 'rspec/usecases/contents/content'
require 'rspec/usecases/groups/base_group'
require 'rspec/usecases/groups/group'
require 'rspec/usecases/groups/usecase'
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

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'Rspec::Usecases::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('rspec/usecases/version') }
  version   = Rspec::Usecases::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
