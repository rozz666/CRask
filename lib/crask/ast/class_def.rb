module CRask
  module Ast
    class ClassDef
      attr_reader :name
      attr_accessor :method_defs
      def initialize name
        @name = name
        @method_defs = []
      end
    end
  end
end