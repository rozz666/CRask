module CRask
  module Ast
    class MethodDef
      def get_method_code class_name, name_gen, arg_decl, stmt_gen
        method_name = name_gen.get_method_name class_name, name, args
        self_name = name_gen.get_self_name
        "CRASK_OBJECT #{method_name}(#{arg_decl.generate_function_args self_name}) {\n" +
        arg_decl.generate_from_self_arg(self_name, args) +
        stmt_gen.generate_statements(stmts) +
        "    return CRASK_NIL;\n" +
        "}\n"
      end
    end
    class CtorDef
      def get_method_code class_name, name_gen, arg_decl, stmt_gen
        ctor_name = name_gen.get_ctor_name class_name, name, args
        decorated_class_name = name_gen.get_class_name class_name
        class_self_name = name_gen.get_class_self_name
        self_name = name_gen.get_self_name
        "CRASK_OBJECT #{ctor_name}(#{arg_decl.generate_function_args class_self_name}) {\n"+
        arg_decl.generate_from_self_arg(class_self_name, args) +
        "    CRASK_OBJECT #{self_name} = crask_createInstance(#{decorated_class_name});\n" +
        "    return #{self_name};\n" +
        "}\n"
      end
    end
    class DtorDef
      def get_method_code class_name, name_gen, arg_decl, stmt_gen
        dtor_name = name_gen.get_dtor_name class_name
        "void #{dtor_name}(CRASK_OBJECT self) {\n}\n"
      end
    end
  end
  class MethodCodeGenerator
    def initialize name_gen, arg_decl, stmt_gen
      @name_gen = name_gen
      @arg_decl = arg_decl
      @stmt_gen = stmt_gen
    end
    def generate class_name, method_def
      method_def.get_method_code class_name, @name_gen, @arg_decl, @stmt_gen
    end
  end
end