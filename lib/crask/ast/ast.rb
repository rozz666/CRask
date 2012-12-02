require 'crask/ast/class_def'
require 'crask/ast/method_def'

module CRask
  module Ast
    class Ast
      attr_accessor :classes
      def initialize
        @classes = []
      end
    end
  end
end