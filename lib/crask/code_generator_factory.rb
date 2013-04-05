require 'crask/symbol_name_generator'
require 'crask/method_code_generator'
require 'crask/class_generator'
require 'crask/default_methods_generator'
require 'crask/var_arg_declarator'
require 'crask/argument_ordering_policy'
require 'crask/method_name_generator'
require 'crask/statement_code_generator'
require 'crask/assignment_code_generator'

module CRask
  class CodeGeneratorFactory
    def createCodeGenerator
      arg_ordering_policy = ArgumentOrderingPolicy.new
      symbol_name_gen = CRask::SymbolNameGenerator.new arg_ordering_policy
      method_name_generator = CRask::MethodNameGenerator.new arg_ordering_policy
      arg_decl = CRask::VarArgDeclarator.new symbol_name_gen
      assignment_gen = CRask::AssignmentCodeGenerator.new symbol_name_gen
      stmt_gen = CRask::StatementCodeGenerator.new assignment_gen
      method_code_gen = CRask::MethodCodeGenerator.new symbol_name_gen, arg_decl, stmt_gen
      class_gen = CRask::ClassGenerator.new symbol_name_gen, method_name_generator, method_code_gen
      CRask::CodeGenerator.new(symbol_name_gen, method_code_gen, class_gen)
    end
  end
end