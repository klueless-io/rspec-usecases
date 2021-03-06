# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'rspec/usecases'
require 'support/shared_comprehensive_usecases'
require 'support/shared_simple_usecases'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # ----------------------------------------------------------------------
  # Usecase Documentor
  # ----------------------------------------------------------------------

  Rspec::Usecases.configure(config)

  # declare an exclusion filter (you must turn this setting to false if you want to specifically run usecases tests)
  is_continuous_integration = ENV['USAGE_CI'].is_a?(String) && %w[github github_actions].include?(ENV['USAGE_CI'].downcase)
  is_exclude_usecases_in_development = false
  config.filter_run_excluding usecases: (is_continuous_integration || is_exclude_usecases_in_development)

  # Documentor only comes into existence if :usecases exists
  config.before(:context, :usecases) do
    # puts '-' * 70
    # puts self.class
    # puts '-' * 70
    @documentor = Rspec::Usecases::Documentor.new(self.class)
  end

  config.around(:example) do |example|
    stdout_saved = $stdout
    $stdout      = StringIO.new
    example.run

    example.metadata[:usecase_content].captured_output = $stdout.string if example.metadata[:usecase_content]
  ensure
    @capture     = $stdout
    $stdout      = stdout_saved
  end

  config.after do |example|
    example.metadata[:usecase_content]&.after_hook
  end

  config.after(:context, :usecases) do
    unless @documentor.document.skip_render?
      @documentor.document.after_context
      @documentor.render
    end
    # puts '-' * 70
    # puts self.class
    # puts '-' * 70
  end
end

def fixture_path(name)
  File.join(File.expand_path('fixtures', __dir__), name)
end
