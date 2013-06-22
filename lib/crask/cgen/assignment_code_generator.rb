module CRask
  module Ast
    class Identifier
      def generate_ast name_gen, config, method_call_gen #TODO: extract variable generator
        if name == config.nil_id
          CAst::Variable.new config.nil_var
        else
          CAst::Variable.new name_gen.get_local_name(name)
        end
      end
    end
    class MethodCall
      def generate_ast name_gen, config, method_call_gen
        method_call_gen.generate_ast(self)
      end
    end
  end
  class AssignmentCodeGenerator
    def initialize name_gen, config, method_call_gen
      @name_gen = name_gen
      @config = config
      @method_call_gen = method_call_gen
    end
    def generate_ast assignment
      left = CAst::Variable.new @name_gen.get_local_name(assignment.left.name)
      right = assignment.right.generate_ast @name_gen, @config, @method_call_gen
      [ CAst::Assignment.new(left, right) ]
    end
  end
end