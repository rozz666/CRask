module CRask
  module Ast
    class MethodDef
      def get_method_code class_name, name_gen, arg_decl
        method_name = name_gen.get_method_name class_name, name, args
        "CRASK_OBJECT #{method_name}(#{arg_decl.generate_function_args}) {\n" +
        arg_decl.generate_method_args(args) +
        "    return CRASK_NIL;\n" +
        "}\n"
      end
    end
    class CtorDef
      def get_method_code class_name, name_gen, arg_decl
        ctor_name = name_gen.get_ctor_name class_name, name, args
        decorated_class_name = name_gen.get_class_name class_name
        "CRASK_OBJECT #{ctor_name}(CRASK_OBJECT classSelf, ...) {\n"+
        arg_decl.generate_from_self_arg("classSelf", args) +
        "    CRASK_OBJECT self = crask_createInstance(#{decorated_class_name});\n" +
        "    return self;\n" +
        "}\n"
      end
    end
    class DtorDef
      def get_method_code class_name, name_gen, arg_decl
        dtor_name = name_gen.get_dtor_name class_name
        "void #{dtor_name}(CRASK_OBJECT self) {\n}\n"
      end
    end
  end
  class MethodCodeGenerator
    def initialize name_gen, arg_decl
      @name_gen = name_gen
      @arg_decl = arg_decl
    end
    def generate class_name, method_def
      method_def.get_method_code class_name, @name_gen, @arg_decl
    end
  end
end