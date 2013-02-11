module CRask
  module Ast
    class ClassDef
      def self.with_name name
        ClassDef.new name
      end
      def self.with_name_and_dtor name
        ClassDef.new name, [ DtorDef.new ]
      end
      def self.with_name_and_two_methods name, methodName1, methodName2
        ClassDef.new name, [ MethodDef.new(methodName1, []), MethodDef.new(methodName2, []) ]
      end
      def self.with_name_and_ctors name, *ctorNames
        ClassDef.new name, ctorNames.map { |cname| CtorDef.new cname, [] }
      end
      def self.with_name_and_ctors_with_args name, *namesAndArgs
        ClassDef.new name, namesAndArgs.map { |nameAndArgs| CtorDef.new nameAndArgs[0], nameAndArgs[1] }
      end
    end
  end
end