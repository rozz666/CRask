require 'crask/cast/module'

module CRask
  class CodeGenerator
    def initialize class_gen, class_decl_gen
      @class_gen = class_gen
      @class_decl_gen = class_decl_gen
    end
    
    def generate_ast ast
      global_vars = ast.stmts.map { |s| @class_decl_gen.generate_declaration_ast(s) }
      functions = ast.stmts.map { |s| @class_gen.generate_method_definitions_ast(s) }.flatten
      registrations = ast.stmts.map { |s| @class_gen.generate_registration_ast(s) }.flatten
      functions << CAst::Function.new("int", "main", [], [], registrations)
      CAst::Module.new([ "crask.h", "stdarg.h" ], global_vars, functions)
    end
  end
end