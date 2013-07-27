require 'crask/cast/call_facade'

module CRask
  class MethodCallGenerator
    def initialize config, name_gen
      @config, @name_gen = config, name_gen
    end
    def generate_ast method_call
      class_obj = CAst::Call.function("crask_getClassObject", [ CAst::Variable.new(@name_gen.get_class_name(method_call.object))])
      get_impl = CAst::Call.function("crask_getMethodImplForObject", [  CAst::String.new(method_call.method), class_obj ])
      CAst::Call.new(get_impl, [ class_obj ] + [ CAst::Variable.new(@config.nil_var) ] * method_call.args.count)
    end
  end
end
