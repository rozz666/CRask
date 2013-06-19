module CRask
  class ReferenceCountingGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_retain_ast retain
      local = CAst::Variable.new(@name_gen.get_local_name(retain.name))
      [ CAst::FunctionCall.new("crask_retain", [ local ]) ]
    end
  end
end
