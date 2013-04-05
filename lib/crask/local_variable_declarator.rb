module CRask
  class LocalVariableDeclarator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_variables vars
      return "" if vars.empty?
      "    CRASK_OBJECT #{vars.map{ |v| @name_gen.get_local_name(v) }.join(", ")};\n"
    end
  end
end