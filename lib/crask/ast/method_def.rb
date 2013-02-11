module CRask
  module Ast
    class MethodDef
      attr_accessor :name, :args
      def initialize name, args
        @name = name
        @args = args
      end
    end
  end
end