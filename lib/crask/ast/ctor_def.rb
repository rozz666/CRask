module CRask
  module Ast
    class CtorDef
      attr_reader :name, :args
      attr_accessor :stmts
      def initialize name, args
        @name = name
        @args = args
        @stmts = []
      end
    end
  end
end