module CRask
  class AssignmentCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate assignment
      local_name = @name_gen.get_local_name(assignment.left)
      "    #{local_name} = #{@name_gen.get_nil_name};\n" +
      "    crask_retain(#{local_name});\n"
    end
  end
end