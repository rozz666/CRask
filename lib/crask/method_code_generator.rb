module CRask
  class MethodCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate class_name, method_def
      method_name = @name_gen.get_method_name class_name, method_def.name
      "CRASK_OBJECT #{method_name}(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n"
    end
  end
end