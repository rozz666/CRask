require 'crask/ast/class_def'
require 'crask/ast/method_def'

module CRask
  module Ast
    class Ast
      attr_accessor :stmts
      def initialize
        @stmts = []
      end
    end
  end
end