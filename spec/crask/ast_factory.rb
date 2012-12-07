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

      def self.with_two_classes_with_methods klass1, method1, klass2, method2
        Ast.new [
          ClassDef.new(klass1, [ MethodDef.new(method1) ]),
          ClassDef.new(klass2, [ MethodDef.new(method2) ]) ]
      end
    end
  end
end