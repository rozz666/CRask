module CRask
  class AssignmentCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_ast assignment
      left = CAst::Variable.new @name_gen.get_local_name(assignment.left.name)
      if assignment.right.name == "nil"
        right = CAst::Variable.new @name_gen.get_nil_name
      else
        right = CAst::Variable.new @name_gen.get_local_name(assignment.right.name)
      end
      [ CAst::Assignment.new(left, right) ]
    end
  end
end