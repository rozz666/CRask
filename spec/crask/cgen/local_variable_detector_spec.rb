require 'crask/cgen/local_variable_detector'
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
        Ast::Assignment.to_var("x"),
        Ast::Assignment.to_var("b"),
        Ast::Assignment.to_var("c") ]
      @detector.find_local_vars(stmts).should be_identifiers("x", "b", "c")
    end
    it "should only use assignments" do
      stmts = [
        Ast::Retain.new("x"),
        Ast::Assignment.to_var("b"),
        Ast::Release.new("c") ]
      @detector.find_local_vars(stmts).should be_identifiers("b")
    end
    it "should ignore repeated variables" do
      stmts = [
        Ast::Assignment.to_var("b"),
        Ast::Assignment.to_var("a"),
        Ast::Assignment.to_var("b") ]
      @detector.find_local_vars(stmts).map(&:name).sort.should eq([ "a", "b" ])
    end
  end
end
