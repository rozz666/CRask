require 'crask/assignment_code_generator'
require 'crask/cast_matchers'

module CRask
 
  describe :AssignmentCodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = AssignmentCodeGenerator.new @name_gen
    end
    it "should generate C AST for a nil assignment to a local variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      @name_gen.should_receive(:get_nil_name).and_return("NIL")
      
      stmts = @gen.generate_ast(Ast::AssignmentDef.to_var_from_var("a", "nil"))
      
      stmts.should have(1).statement
      assignment = stmts[0]
      assignment.should be_a_kind_of(CAst::Assignment)
      assignment.left.should be_a_C_variable("LOCAL")
      assignment.right.should be_a_C_variable("NIL")
    end
    it "should generate C AST for an assignment to a local variable from another local variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("A")
      @name_gen.should_receive(:get_local_name).with("b").and_return("B")
      
      stmts = @gen.generate_ast(Ast::AssignmentDef.to_var_from_var("a", "b"))
      
      stmts.should have(1).statement
      assignment = stmts[0]
      assignment.should be_a_kind_of(CAst::Assignment)
      assignment.left.should be_a_C_variable("A")
      assignment.right.should be_a_C_variable("B")
    end
  end
end