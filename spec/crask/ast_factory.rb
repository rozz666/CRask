module CRask
  module Ast
    class Ast
      def self.with_two_classes first, second
        Ast.new [ ClassDef.new(first), ClassDef.new(second) ]
      end

      def self.with_class_with_two_methods klass, first, second
        Ast.new [ ClassDef.new(klass,
          [ MethodDef.new(first), MethodDef.new(second) ]) ]
      end
    end
  end
end