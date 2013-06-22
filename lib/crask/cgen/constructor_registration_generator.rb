module CRask
  class ConstructorRegistrationGenerator
    def initialize symbol_name_gen, method_name_gen
      @symbol_name_gen = symbol_name_gen
      @method_name_gen = method_name_gen
    end
    def generate_ast ctor, class_name, class_var_name
      func_addr = CAst::VariableAddress.new(@symbol_name_gen.get_ctor_name(class_name, ctor.name, ctor.args))
      public_name = CAst::String.new(@method_name_gen.generate(ctor.name, ctor.args))
      class_var = CAst::Variable.new(class_var_name)
      CAst::Call.function("crask_addClassMethodToClass", [ func_addr, public_name, class_var ])
    end
  end
end
