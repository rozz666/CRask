require 'crask/ast/class_def'
require 'crask/ast/method_def'
require 'crask/ast/ctor_def'

module CRask
  module Ast
    class Ast
      attr_accessor :stmts
      def initialize stmts = []
        @stmts = stmts
      end
    end
  end
end