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
        "void #{ctor_name}(CRASK_OBJECT self, ...) {\n}"
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