require 'crask/c_include_printer'

module CRask
  class CodeGenerator
    def initialize name_gen, method_gen, class_gen
      @name_gen = name_gen
      @method_gen = method_gen
      @class_gen = class_gen
    end

    def generate_headers ast
      CIncludePrinter.new.print([ "crask.h", "stdarg.h" ])
    end
    
    def generate_class_declarations ast
      ast.stmts.map { |s| @class_gen.generate_declaration(s) }.join
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
      ast.stmts.map do |s|
        @class_gen.generate_method_definitions s
      end.join
    end
  end
end