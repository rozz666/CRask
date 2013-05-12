module CRask
  module Ast
    class MethodDef
      def get_method_code class_name, name_gen, arg_decl, stmt_gen, stmt_printer, local_decl
        method_name = name_gen.get_method_name class_name, name, args
        self_name = name_gen.get_self_name
        "CRASK_OBJECT #{method_name}(#{arg_decl.generate_function_args self_name}) {\n" +
        local_decl.generate_variables(args) +
        arg_decl.generate_initialization(self_name, args) +
        stmt_printer.print(stmt_gen.generate_ast(stmts)) +
        "    return CRASK_NIL;\n" +
        "}\n"
      end
    end
    class CtorDef
      def get_method_code class_name, name_gen, arg_decl, stmt_gen, stmt_printer, local_decl
        ctor_name = name_gen.get_ctor_name class_name, name, args
        decorated_class_name = name_gen.get_class_name class_name
        class_self_name = name_gen.get_class_self_name
        self_name = name_gen.get_self_name
        "CRASK_OBJECT #{ctor_name}(#{arg_decl.generate_function_args class_self_name}) {\n"+
        local_decl.generate_variables(args) +
        arg_decl.generate_initialization(class_self_name, args) +
        "    CRASK_OBJECT #{self_name};\n" + 
        "    #{self_name} = crask_createInstance(#{decorated_class_name});\n" +
        "    return #{self_name};\n" +
        "}\n"
      end
    end
    class DtorDef
      def get_method_code class_name, name_gen, arg_decl, stmt_gen, stmt_printer, local_decl
        dtor_name = name_gen.get_dtor_name class_name
        "void #{dtor_name}(CRASK_OBJECT self) {\n}\n"
      end
    end
  end
  class MethodCodeGenerator
    def initialize name_gen, arg_decl, stmt_gen, stmt_printer, local_decl
      @name_gen = name_gen
      @arg_decl = arg_decl
      @stmt_gen = stmt_gen
      @stmt_printer = stmt_printer
      @local_decl = local_decl
    end
    def generate class_name, method_def
      method_def.get_method_code class_name, @name_gen, @arg_decl, @stmt_gen, @stmt_printer, @local_decl
    end
    def generate_ast class_name, method_def
      name = @name_gen.get_method_name(class_name, method_def.name, method_def.args)
      args = @arg_decl.generate_function_args_ast(@name_gen.get_self_name)
      local_vars = generate_local_vars_ast(method_def)
      stmts = generate_stmts_ast(method_def)
      CAst::Function.new("CRASK_OBJECT", name, args, local_vars, stmts)
    end
    private
    def generate_stmts_ast method_def
      @arg_decl.generate_initialization_ast(@name_gen.get_self_name, method_def.args) +
      @stmt_gen.generate_ast(method_def.stmts) +
      [ CAst::Return.new(CAst::Variable.new(@name_gen.get_nil_name)) ]
    end
    def generate_local_vars_ast method_def
      @local_decl.generate_ast(method_def.args) +
      @arg_decl.generate_local_vars_ast(method_def.args)
    end
  end
end