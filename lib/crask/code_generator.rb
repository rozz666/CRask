module CRask
  module Ast
    class ClassDef
      def registrationCode
        "CRASK_CLASS class_#{@name} = crask_registerClass(\"#{@name}\");\n"
      end
    end

    class MethodDef
      def definitionCode className
        "CRASK_OBJECT class_#{className}_method_#{@name}(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n"
      end
    end
  end

  class CodeGenerator
    def generateHeaders ast
      "#include <crask.h>\n"
    end

    def generateClassRegistrations ast
      ast.stmts.map { |s| s.registrationCode }.join
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