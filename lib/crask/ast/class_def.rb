module CRask
  module Ast
    class ClassDef
      attr_reader :name
      attr_accessor :defs
      def initialize name, defs = []
        @name = name
        @defs = defs
      end
    end
  end
end