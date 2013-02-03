module CRask
  module Ast
    class ClassDef
      def get_declaration_code name_gen
        class_var_name = name_gen.get_class_name(self.name)
        "CRASK_CLASS #{class_var_name};\n"
      end
    end
  end

  class CodeGenerator
    def initialize name_gen, method_gen, class_gen
      @name_gen = name_gen
      @method_gen = method_gen
      @class_gen = class_gen
    end

    def generate_headers ast
      "#include <crask.h>\n"
    end
    
    def generate_class_declarations ast
      ast.stmts.map { |s| s.get_declaration_code @name_gen }.join
    end

    def generate_class_registrations ast
      ast.stmts.map { |s| @class_gen.generate_registration(s) }.join
    end

    def generate_main_block_beginning ast
      "int main() {\n"
    end

    def generate_main_block_ending ast
      "}\n"
    end

    def generate_method_definitions ast
      ast.stmts.map {
        |s| s.defs.map {
          |d| @method_gen.generate s.name, d
        }.join
      }.join
    end
  end
end