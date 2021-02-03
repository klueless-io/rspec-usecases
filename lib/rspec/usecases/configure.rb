# frozen_string_literal: true

module Rspec
  # Usecases
  module Usecases
    # Configure can be called to setup rspec example and
    # example_group names that make sense for documentation
    # rubocop:disable Layout/ExtraSpacing
    def self.configure(config)
      # Feels wrong, as this is overriding context which could effect other libraries
      # it would be nice to get a handle on context and update it, rather then just
      # overriding it.
      #
      # or maybe I have to stop using context in deep hierarchies and use a different
      # example group name such as group
      config.alias_example_group_to :context  , usecase: false
      config.alias_example_group_to :describe , usecase: false

      config.alias_example_group_to :usecase  , usecase: true  , group_type: :usecase
      config.alias_example_group_to :xusecase , usecase: false , group_type: :usecase

      config.alias_example_group_to :group    , usecase: true  , group_type: :group
      config.alias_example_group_to :xgroup   , usecase: false , group_type: :group

      config.alias_example_to :code       , category: :code    , type: :unknown
      config.alias_example_to :ruby       , category: :code    , type: :ruby
      config.alias_example_to :fruby      , category: :code    , type: :ruby       , focus: true
      config.alias_example_to :css        , category: :code    , type: :css
      config.alias_example_to :js         , category: :code    , type: :javascript
      config.alias_example_to :javascript , category: :code    , type: :javascript

      # This may need to be it's own typed
      config.alias_example_to :content    , category: :content, type: :content
      config.alias_example_to :outcome    , category: :content, type: :outcome
      config.alias_example_to :item       , category: :content, type: :item

      config.extend Rspec::Usecases::Helpers
    end
    # rubocop:enable Layout/ExtraSpacing
  end
end
