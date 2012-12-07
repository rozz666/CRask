module CRask
  module Ast
    class ClassDef
      def get_registration_code name_gen
        class_var_name = name_gen.get_class_name(self.name)
        "CRASK_CLASS #{class_var_name} = crask_registerClass(\"#{self.name}\");\n" +
        defs.map { |d| "crask_addMethodToClass(&class_#{self.name}_method_#{d.name}, \"#{d.name}\", #{class_var_name});\n" }.join
      end
    end

    class MethodDef
      def definitionCode className
        "CRASK_OBJECT class_#{className}_method_#{@name}(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n"
      end
    end
  end

  class CodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generateHeaders ast
      "#include <crask.h>\n"
    end

    def generateClassRegistrations ast
      ast.stmts.map { |s| s.get_registration_code @name_gen }.join
    end

    def generateMainBlockBeginning ast
      "int main() {\n"
    end

    def generateMainBlockEnding ast
      "}\n"
    end

    def generateMethodDefinitions ast
      ast.stmts.map {
        |s| s.defs.map {
          |d| d.definitionCode s.name
        }.join
      }.join
    end
  end
end