require 'crask/local_variable_detector'
require 'crask/assignment_factory'
module CRask
  describe :LocalVariableDetector do
    before(:each) do
      @detector = LocalVariableDetector.new
    end
    it "should return nothing for no statements" do
      @detector.find_local_vars([]).should eql([])
    end
    it "should return variables in order definition" do
      stmts = [
        Ast::AssignmentDef.to_var("x"),
        Ast::AssignmentDef.to_var("b"),
        Ast::AssignmentDef.to_var("c") ]
      @detector.find_local_vars(stmts).should eql(["x", "b", "c"])
    end
    it "should only use assignments" do
      stmts = [
        Ast::RetainDef.new("x"),
        Ast::AssignmentDef.to_var("b"),
        Ast::ReleaseDef.new("c") ]
      @detector.find_local_vars(stmts).should eql([ "b" ])
    end
    it "should ignore repeated variables" do
      stmts = [
        Ast::AssignmentDef.to_var("b"),
        Ast::AssignmentDef.to_var("a"),
        Ast::AssignmentDef.to_var("b") ]
      @detector.find_local_vars(stmts).sort.should eql(["a", "b"])
    end
  end
end
