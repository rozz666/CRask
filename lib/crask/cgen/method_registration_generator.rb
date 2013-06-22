module CRask
  class MethodRegistrationGenerator
    def initialize symbol_name_gen, method_name_gen
      @symbol_name_gen = symbol_name_gen
      @method_name_gen = method_name_gen
    end
    def generate_ast method, class_name, class_var_name
      func_addr = CAst::VariableAddress.new(@symbol_name_gen.get_method_name(class_name, method.name, method.args))
      public_name = CAst::String.new(@method_name_gen.generate(method.name, method.args))
      class_var = CAst::Variable.new(class_var_name)
      CAst::Call.function("crask_addMethodToClass", [ func_addr, public_name, class_var ])
    end
  end
end
