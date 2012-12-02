module CRask
  module Ast
    class MethodDef
      attr_accessor :name
      def initialize name
        @name = name
      end
    end
  end
end