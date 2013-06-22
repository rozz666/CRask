module CRask
  class ClassRegistrationGenerator
    def generate_ast class_def, class_var_name
      class_registration_call = CAst::Call.function("crask_registerClass", [ CAst::String.new(class_def.name) ])
      CAst::Assignment.new(CAst::Variable.new(class_var_name), class_registration_call)
    end
  end
end
