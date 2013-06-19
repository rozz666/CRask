module CRask
  class AssignmentCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_ast assignment
      left = CAst::Variable.new @name_gen.get_local_name(assignment.left)
      right = CAst::Variable.new @name_gen.get_nil_name
      [ CAst::Assignment.new(left, right) ]
    end
  end
end