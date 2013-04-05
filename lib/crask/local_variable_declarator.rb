module CRask
  class LocalVariableDeclarator
    def generate_variables vars
      return "" if vars.empty?
      "    CRASK_OBJECT #{vars[0]};\n"
    end
  end
end