require 'crask/ast/class_def'
require 'crask/ast/method_def'
require 'crask/ast/ctor_def'
require 'crask/ast/dtor_def'
require 'crask/ast/assignment'
require 'crask/ast/retain_def'
require 'crask/ast/release_def'
require 'crask/ast/method_call'
require 'crask/ast/identifier'

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