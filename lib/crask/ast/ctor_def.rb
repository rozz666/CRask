module CRask
  module Ast
    class CtorDef
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end