module CRask
  class StatementCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_statements stmts
      return "" if stmts.empty?
      local_name = @name_gen.get_local_name(stmts[0].left)
      "    #{local_name} = #{@name_gen.get_nil_name};\n" +
      "    crask_retain(#{local_name});\n"
    end
  end
end