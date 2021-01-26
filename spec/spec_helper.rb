# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'rspec/usecases'
require 'support/usecase_examples'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Add rspec support helpers
  config.include UsecaseExamples

  # ----------------------------------------------------------------------
  # Usecase Documentor
  # ----------------------------------------------------------------------

  Rspec::Usecases.configure(config)

  config.extend Rspec::Usecases

  config.before(:context, :usecases) do
    puts '-' * 70
    puts self.class
    puts '-' * 70
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  config.after(:context, :usecases) do
    @documentor.render
    puts '-' * 70
    puts self.class
    puts '-' * 70
  end
end

def fixture_path(name)
  File.join(File.expand_path('fixtures', __dir__), name)
end
