module CRask
  class LocalVariableDeclarator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_ast vars
      vars.map { |v| CAst::LocalVariable.new("CRASK_OBJECT", @name_gen.get_local_name(v)) }
    end
  end
end