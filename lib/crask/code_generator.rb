module CRask
  module Ast
    class ClassDef
      def get_registration_code name_gen
        class_var_name = name_gen.get_class_name(self.name)
        "CRASK_CLASS #{class_var_name} = crask_registerClass(\"#{self.name}\");\n" +
        defs.map { |d| d.get_registration_code self.name, class_var_name, name_gen }.join
      end
    end

    class MethodDef
      def get_registration_code class_name, class_var_name, name_gen
        "crask_addMethodToClass(&#{name_gen.get_method_name(class_name, self.name)}, \"#{self.name}\", #{class_var_name});\n"
      end

      def definitionCode className, name_gen
        "CRASK_OBJECT #{name_gen.get_method_name(className, self.name)}(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n"
      end
    end
  end

  class CodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end

    def generate_headers ast
      "#include <crask.h>\n"
    end

    def generate_class_registrations ast
      ast.stmts.map { |s| s.get_registration_code @name_gen }.join
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
          |d| d.definitionCode s.name, @name_gen
        }.join
      }.join
    end
  end
end