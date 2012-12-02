module CRask
  module Ast
    class ClassDef
      attr_reader :name
      attr_accessor :defs
      def initialize name
        @name = name
        @defs = []
      end
    end
  end
end