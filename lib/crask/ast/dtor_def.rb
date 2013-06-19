module CRask
  module Ast
    class DtorDef
      attr_accessor :stmts
      def initialize
        @stmts = []
      end
    end
  end
end