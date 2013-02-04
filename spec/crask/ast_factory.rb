module CRask
  module Ast
    class Ast
      def self.with_two_classes first, second
        Ast.new [ ClassDef.new(first), ClassDef.new(second) ]
      end

      def self.with_two_classes_with_methods klass1, method1, klass2, method2
        Ast.new [
          ClassDef.new(klass1, [ MethodDef.new(method1) ]),
          ClassDef.new(klass2, [ MethodDef.new(method2) ]) ]
      end
      
      def self.with_two_classes_with_dtors
        Ast.new [
          ClassDef.new("A", [ DtorDef.new ]),
          ClassDef.new("B", [ DtorDef.new ]) ]
      end
    end
  end
end