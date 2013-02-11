require 'crask/name_generator'
require 'crask/method_code_generator'
require 'crask/class_generator'
require 'crask/default_methods_generator'
require 'crask/var_arg_declarator'

module CRask
  class CodeGeneratorFactory
    def createCodeGenerator
      name_gen = CRask::NameGenerator.new nil
      arg_decl = CRask::VarArgDeclarator.new name_gen
      method_code_gen = CRask::MethodCodeGenerator.new name_gen, arg_decl
      class_gen = CRask::ClassGenerator.new name_gen, method_code_gen
      CRask::CodeGenerator.new(name_gen, method_code_gen, class_gen)
    end
  end
end