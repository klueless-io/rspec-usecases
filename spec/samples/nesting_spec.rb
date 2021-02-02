# frozen_string_literal: true

RSpec.describe 'Nesting', 
               :usecases,
               :jsonX,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/nesting.md',
               document_title: 'Dealing with nested types',
               document_description: 'What happens when you have describe/context/usecase at different levels' do

  # Deep level context/describe is currently be dealt with via configuration
  #
  # see: lib/rspec/usecases/configure.rb
  # Feels wrong, as this is overriding context which could effect other libraries
  # it would be nice to get a handle on context and update it, rather then just
  # overriding it.
  #
  # or maybe I have to stop using context in deep hierarchies and use a different
  # example group name such as group
  # config.alias_example_group_to :context  , usecase: false
  # config.alias_example_group_to :describe , usecase: false

  describe 'more stuff' do
    context 'with deeper' do
      context 'and deeper levels' do
        usecase 'USECASE: 1st' do
          ruby do
            puts 'this code should show'
          end
          # Beware: this context will inherit settings from it's parent
          # and since it's parent is a usecase, it will inherit the
          # setting usecase: true and thus believe it is a usecase too
          # To deal with this issue, you can either have a new example_group or
          # config.alias_example_group_to :context  , usecase: false
          context 'this really deep "context" should not show up in JSON, Debug or Markdown' do
            ruby 'this code should not show' do
              puts 'this code should not show'
            end
          end

          # see: previous
          # config.alias_example_group_to :describe  , usecase: false
          describe 'this really deep "describe" should not show up in JSON, Debug or Markdown' do
            ruby 'this code should not show' do
              puts 'this code should not show'
            end
          end

          usecase 'USECASE: 2nd' do
            ruby 'this code should show in a nested group' do
              puts 'this code should show in a nested group'
            end
          end


          # see: previous
          # config.alias_example_group_to :describe  , usecase: false
          describe 'ignore' do
            ruby 'this code should not show' do
              puts 'this code should not show'
            end
          end

          usecase 'USECASE: 3rd' do
            ruby 'this code should show in a nested group' do
              puts 'this code should show in a nested group'
            end

            context 'ignore' do
              usecase 'USECASE: 4th' do
                ruby 'this code should show in a nested group' do
                  puts 'this code should show in a nested group'
                end
              end
            end
          end
        end
      end
    end
  end
end
