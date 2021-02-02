# frozen_string_literal: true

module Rspec
  module Usecases
    # Dynamic Option
    module Options
      # Dynamic option will convert a value
      class DynamicOptions < OpenStruct
        # rubocop:disable Metrics/CyclomaticComplexity
        def initialize(option_key, value, api = {})
          super()

          # This will load app the default values
          parse(api)

          self.empty = value.nil? || (value.is_a?(Hash) && value.empty?)

          if !value.nil? && (value.is_a?(TrueClass) || value.is_a?(FalseClass))
            self.empty = value.is_a?(FalseClass)
            return
          end

          return if empty?
          return if value == option_key

          parse(value)
        end
        # rubocop:enable Metrics/CyclomaticComplexity

        def active?
          !empty?
        end

        def empty?
          empty
        end

        def to_h
          DynamicOptions.struct_to_hash(self)
        end

        # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize
        def self.struct_to_hash(data)
          # No test yet
          if data.is_a?(Array)
            return data.map { |v| v.is_a?(OpenStruct) ? struct_to_hash(v) : v }
          end

          data.each_pair.with_object({}) do |(key, value), hash|
            case value
            when OpenStruct
              hash[key] = struct_to_hash(value)
            when Array
              # No test yet
              values = value.map { |v| v.is_a?(OpenStruct) ? struct_to_hash(v) : v }
              hash[key] = values
            else
              hash[key] = value
            end
          end
        end
        # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize

        private

        def parse(value)
          case value
          when Array
            parse_array(value)
          when Hash
            parse_hash(value)
          else
            parse_value(value)
          end
        end

        def parse_hash(data)
          data.each do |k, v|
            send("#{k}=", v)
          end
        end

        def parse_array(values)
          values.map do |value|
            case value
            when Symbol, String
              parse_symbol_or_string(value)
            when Hash
              parse_hash(value)
            else
              raise Rspec::Usecases::Error, 'Unknown option paramater'
            end
          end
        end

        def parse_symbol_or_string(value)
          send("#{value}=", true)
        end
      end
    end
  end
end
