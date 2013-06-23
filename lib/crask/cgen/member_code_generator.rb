require 'crask/cast/function'
require 'crask/cast/call_facade'
require 'crask/cgen/method_code_generator'
require 'crask/cgen/constructor_code_generator'
require 'crask/cgen/destructor_code_generator'

module CRask
  module Ast
    class MethodDef
      def generate_ast class_name, name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
        MethodCodeGenerator.new(config, name_gen, arg_decl, stmt_gen, local_decl, local_detector).generate_ast(self, class_name)
      end
    end
    class CtorDef
      def generate_ast class_name, name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
        ConstructorCodeGenerator.new(config, name_gen, arg_decl, stmt_gen, local_decl, local_detector).generate_ast self, class_name
      end
    end
    class DtorDef
      def generate_ast class_name, name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
        DestructorCodeGenerator.new(config, name_gen).generate_ast(class_name)
      end
    end
  end
  class MemberCodeGenerator
    def initialize name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
      @name_gen = name_gen
      @arg_decl = arg_decl
      @stmt_gen = stmt_gen
      @local_decl = local_decl
      @local_detector = local_detector
      @config = config
    end
    def generate_ast class_name, method_def
      method_def.generate_ast class_name, @name_gen, @arg_decl, @stmt_gen, @local_decl, @local_detector, @config
    end
  end
end