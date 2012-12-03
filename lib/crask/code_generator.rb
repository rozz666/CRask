module CRask
  module Ast
    class Ast::ClassDef
      def registrationCode
        "CRASK_CLASS class_#{@name} = crask_registerClass(\"#{@name}\")\n"
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
  end
end