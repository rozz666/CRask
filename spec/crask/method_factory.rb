module CRask
  module Ast
    class MethodDef
      def self.with_stmts stmts
        MethodDef.new nil, nil, stmts
      end
    end
  end
end