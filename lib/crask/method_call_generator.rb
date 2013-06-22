module CRask
  class MethodCallGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_ast method_call
      class_obj = CAst::FunctionCall.new("crask_getClassObject", [ CAst::Variable.new(@name_gen.get_class_name(method_call.object))])
      get_impl = CAst::FunctionCall.new("crask_getMethodImplForObject", [  CAst::String.new(method_call.method), class_obj ])
      CAst::FunctionCall.new(get_impl, [ class_obj ])
    end
  end
end
