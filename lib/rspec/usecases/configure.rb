# frozen_string_literal: true

module Rspec
  # Usecases
  module Usecases
    # Configure can be called to setup rspec example and
    # example_group names that make sense for documentation
    # rubocop:disable Layout/ExtraSpacing
    def self.configure(config)
      config.alias_example_group_to :usecase  , usecase: true
      config.alias_example_group_to :xusecase , usecase: false

      config.alias_example_to :code       , content_type: :code
      config.alias_example_to :ruby       , content_type: :code, code_type: :ruby
      config.alias_example_to :fruby      , content_type: :code, code_type: :ruby       , focus: true
      config.alias_example_to :css        , content_type: :code, code_type: :css
      config.alias_example_to :js         , content_type: :code, code_type: :javascript
      config.alias_example_to :javascript , content_type: :code, code_type: :javascript

      # This may need to be it's own type
      config.alias_example_to :content    , content_type: :outcome
      config.alias_example_to :outcome    , content_type: :outcome

      config.extend Rspec::Usecases::Helpers
    end
    # rubocop:enable Layout/ExtraSpacing
  end
end
