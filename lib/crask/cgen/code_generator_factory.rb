require 'crask/cgen/symbol_name_generator'
require 'crask/cgen/method_code_generator'
require 'crask/cgen/class_generator'
require 'crask/cgen/default_methods_generator'
require 'crask/cgen/var_arg_declarator'
require 'crask/cgen/argument_ordering_policy'
require 'crask/cgen/method_name_generator'
require 'crask/cgen/statement_code_generator'
require 'crask/cgen/assignment_code_generator'
require 'crask/cgen/local_variable_declarator'
require 'crask/cgen/code_generator'
require 'crask/cgen/reference_counting_generator'
require 'crask/cgen/local_variable_detector'
require 'crask/cgen/method_call_generator'
require 'crask/cgen/generator_configuration'

module CRask
  class CodeGeneratorFactory
    def createCodeGenerator
      config = GeneratorConfiguration.new
      arg_ordering_policy = ArgumentOrderingPolicy.new
      symbol_name_gen = CRask::SymbolNameGenerator.new arg_ordering_policy
      method_name_generator = CRask::MethodNameGenerator.new arg_ordering_policy
      arg_decl = CRask::VarArgDeclarator.new symbol_name_gen, config
      method_call_gen = MethodCallGenerator.new symbol_name_gen
      assignment_gen = CRask::AssignmentCodeGenerator.new symbol_name_gen, config, method_call_gen
      reference_counting_gen = ReferenceCountingGenerator.new symbol_name_gen
      stmt_gen = CRask::StatementCodeGenerator.new({
        :Assignment => assignment_gen,
        :ReferenceCounting => reference_counting_gen
      })
      local_var_decl = LocalVariableDeclarator.new symbol_name_gen, config
      local_var_detector = LocalVariableDetector.new
      method_code_gen = CRask::MethodCodeGenerator.new symbol_name_gen, arg_decl, stmt_gen, local_var_decl, local_var_detector, config
      class_gen = CRask::ClassGenerator.new symbol_name_gen, method_name_generator, method_code_gen, config
      CRask::CodeGenerator.new(class_gen)
    end
  end
end