# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in rspec_usecases.gemspec
gemspec

group :development do
  if ENV['RUBY_DEBUG_DEVELOPMENT']
    # Currently conflicts with GitHub actions and so only available when
    # environment varialbe is set.
    # On Mac:
    # ```export RUBY_DEBUG_DEVELOPMENT=true```
    gem 'jazz_fingers'
    gem 'pry-coolline', github: 'owst/pry-coolline', branch: 'support_new_pry_config_api'
  end
end

group :development, :test do
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'rake', '~> 12.0'
  gem 'rake-compiler', require: false
  gem 'rspec', '~> 3.0'
  gem 'rubocop'
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

# Temporary path:
# group :test do
#   gem 'k_usecases', path: '~/dev/kgems/k_usecases'
# end
