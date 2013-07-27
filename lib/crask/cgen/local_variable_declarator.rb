module CRask
  class LocalVariableDeclarator
    def initialize name_gen, config
      @name_gen = name_gen
      @config = config
    end
    def generate_ast vars
      vars.map { |v| CAst::LocalVariable.new(@config.object_type, @name_gen.get_local_name(v.name)) }
    end
  end
end