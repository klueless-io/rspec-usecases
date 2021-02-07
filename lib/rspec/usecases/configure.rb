# frozen_string_literal: true

module Rspec
  # Usecases
  module Usecases
    # # Adds an alias_example_group_to for both named and named + focus: true
    # def self.add_example_group(name, **args); end

    def self.add_example(config, name, **args)
      config.alias_example_to name, args
    end

    def self.add_focused_example(config, name, **args)
      config.alias_example_to name, args

      focus_args = {
        focus: true
      }.merge(args)

      config.alias_example_to "f#{name}".to_sym, focus_args
    end

    # Configure can be called to setup rspec example and
    # example_group names that make sense for documentation
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

      add_focused_example(config, :code       , category: :code    , type: :unknown)

      add_focused_example(config, :ruby       , category: :code    , type: :ruby)
      add_focused_example(config, :css        , category: :code    , type: :css)
      add_focused_example(config, :js         , category: :code    , type: :javascript)
      add_focused_example(config, :javascript , category: :code    , type: :javascript)

      # This may need to be it's own typed
      add_focused_example(config, :content    , category: :content, type: :content)
      add_focused_example(config, :outcome    , category: :content, type: :outcome)
      add_focused_example(config, :item       , category: :content, type: :item)

      add_example(config        , :hr         , category: :content, type: :hr)

      config.extend Rspec::Usecases::Helpers
    end
  end
end
