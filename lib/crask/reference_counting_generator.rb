require 'crask/cast/call_facade'

module CRask
  class ReferenceCountingGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_retain_ast retain
      local = CAst::Variable.new(@name_gen.get_local_name(retain.name))
      [ CAst::Call.function("crask_retain", [ local ]) ]
    end
    def generate_release_ast retain
      local = CAst::Variable.new(@name_gen.get_local_name(retain.name))
      [ CAst::Call.function("crask_release", [ local ]) ]
    end
  end
end
