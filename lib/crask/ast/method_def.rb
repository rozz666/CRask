module CRask
  module Ast
    class MethodDef
      attr_accessor :name, :args, :stmts
      def initialize name, args, stmts = []
        @name = name
        @args = args
        @stmts = stmts
      end
    end
  end
end