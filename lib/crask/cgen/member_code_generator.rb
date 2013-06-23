require 'crask/cast/function'
require 'crask/cast/call_facade'

module CRask
  module Ast
    class MethodDef
      def generate_ast class_name, name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
        name = name_gen.get_method_name(class_name, @name, @args)
        args = arg_decl.generate_function_args_ast(config.self_var)
        local_vars = generate_local_vars_ast(local_decl, arg_decl, local_detector)
        stmts = generate_stmts_ast(name_gen, arg_decl, stmt_gen, config)
        CAst::Function.new(config.object_type, name, args, local_vars, stmts)
      end
      private
      def generate_stmts_ast name_gen, arg_decl, stmt_gen, config
        arg_decl.generate_initialization_ast(config.self_var, @args) +
        stmt_gen.generate_ast(@stmts) +
        [ CAst::Return.new(CAst::Variable.new(config.nil_var)) ]
      end
      def generate_local_vars_ast local_decl, arg_decl, local_detector
        local_decl.generate_ast(@args +         local_detector.find_local_vars(@stmts)) +
        arg_decl.generate_local_vars_ast(@args)
      end
    end
    class CtorDef
      def generate_ast class_name, name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
        name = name_gen.get_ctor_name(class_name, @name, @args)
        args = arg_decl.generate_function_args_ast(config.class_self_var)
        local_vars = generate_local_vars_ast(local_decl, arg_decl, config.self_var, config)
        stmts = generate_stmts_ast(class_name, name_gen, arg_decl, stmt_gen, config)
        CAst::Function.new(config.object_type, name, args, local_vars, stmts)
      end
      private
      def generate_local_vars_ast local_decl, arg_decl, self_name, config
        [ CAst::LocalVariable.new(config.object_type, self_name) ] +
        local_decl.generate_ast(@args) +
        arg_decl.generate_local_vars_ast(@args)
      end   
      def generate_stmts_ast class_name, name_gen, arg_decl, stmt_gen, config
        arg_decl.generate_initialization_ast(config.class_self_var, @args) +
        [ generate_create_instance(class_name, name_gen, config) ] +
        [ CAst::Return.new(CAst::Variable.new(config.self_var)) ]        
      end
      def generate_create_instance class_name, name_gen, config
        create_instance = CAst::Call.function("crask_createInstance", [ CAst::Variable.new(name_gen.get_class_name(class_name)) ])
        CAst::Assignment.new(CAst::Variable.new(config.self_var), create_instance)
      end
    end
    class DtorDef
      def generate_ast class_name, name_gen, arg_decl, stmt_gen, local_decl, local_detector, config
        return CAst::Function.new(
          "void", name_gen.get_dtor_name(class_name),
          [ CAst::LocalVariable.new(config.object_type, config.self_var) ], [], [])
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