require 'crask/local_variable_detector'
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
        Ast::AssignmentDef.new("x", nil),
        Ast::AssignmentDef.new("b", nil),
        Ast::AssignmentDef.new("c", nil) ]
      @detector.find_local_vars(stmts).should eql(["x", "b", "c"])
    end
  end
end
