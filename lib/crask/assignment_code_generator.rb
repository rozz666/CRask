module CRask
  class AssignmentCodeGenerator
    def initialize name_gen, symbol_table
      @name_gen = name_gen
      @symbol_table = symbol_table
    end
    def generate assignment
      @symbol_table.add_local(assignment.left)
      local_name = @name_gen.get_local_name(assignment.left)
      "    #{local_name} = #{@name_gen.get_nil_name};\n" +
      "    crask_retain(#{local_name});\n"
    end
  end
end