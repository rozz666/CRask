module CRask
  module Ast
    class MethodDef
      def get_method_code class_name, name_gen
        method_name = name_gen.get_method_name class_name, name
        "CRASK_OBJECT #{method_name}(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n"
      end
    end
    class CtorDef
      def get_method_code class_name, name_gen
        ctor_name = name_gen.get_ctor_name class_name, name
        decorated_class_name = name_gen.get_class_name class_name
        "CRASK_OBJECT #{ctor_name}(CRASK_OBJECT classSelf, ...) {\n"+
        get_args_decl(name_gen) +
        "    CRASK_OBJECT self = crask_createInstance(#{decorated_class_name});\n" +
        "    return self;\n" +
        "}"
      end
      def get_args_decl name_gen
        return "" if args.empty?
        decorated_args = args.map { |a| name_gen.get_local_name a }
        "    CRASK_OBJECT #{decorated_args.join(", ")};\n" +
        "    va_list rask_args;\n" +
        "    va_start(rask_args, classSelf);\n" +
        decorated_args.map { |a| "    #{a} = va_arg(rask_args, CRASK_OBJECT);\n" }.join +
        "    va_end(rask_args);\n"
      end
    end
    class DtorDef
      def get_method_code class_name, name_gen
        dtor_name = name_gen.get_dtor_name class_name
        "void #{dtor_name}(CRASK_OBJECT self) {\n}\n"
      end
    end
  end
  class MethodCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate class_name, method_def
      method_def.get_method_code class_name, @name_gen
    end
  end
end