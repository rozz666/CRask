module CRask
  class DestructorRegistrationGenerator
    def initialize symbol_name_gen
      @symbol_name_gen = symbol_name_gen
    end
    def generate_ast class_name, class_var_name
      func_addr = CAst::VariableAddress.new(@symbol_name_gen.get_dtor_name(class_name))
      class_var = CAst::Variable.new(class_var_name)
      CAst::Call.function("crask_addDestructorToClass", [ func_addr, class_var ])
    end
  end
end
