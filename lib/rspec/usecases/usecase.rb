# frozen_string_literal: true

# require 'rspec/usecases/usecase'

module Rspec
  module Usecases
    # Usecase
    class Usecase
      # 
      attr_accessor :key

      # 
      attr_accessor :title

      # 
      attr_accessor :summary

      # 
      attr_accessor :usage

      # 
      attr_accessor :usage_description

      # 
      attr_accessor :contents

      def initialize
      end

      def debug
        puts "key                           : #{key}"
        puts "title                         : #{title}"
        puts "summary                       : #{summary}"
        puts "usage                         : #{usage}"
        puts "usage_description             : #{usage_description}"
        puts "contents                      : #{contents}"
      end
    end
  end
end
