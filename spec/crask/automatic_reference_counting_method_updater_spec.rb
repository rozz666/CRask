require 'crask/automatic_reference_counting_method_updater'
require 'crask/ast_matchers'
require 'crask/method_factory'

module CRask
  describe :AutomaticReferenceCountingMethodUpdater do
    before(:each) do
      @gen = AutomaticReferenceCountingMethodUpdater.new
    end
    it "should retain variables after assignments and release at the end" do
      assignments = [ Ast::AssignmentDef.new("a", nil), Ast::AssignmentDef.new("b", nil) ]
      method = Ast::MethodDef.with_stmts(assignments)
      @gen.update_ast method
      method.should have(6).stmts
      stmts = method.stmts 
      stmts[0].should be(assignments[0])
      stmts[1].should be_a_retain("a")
      stmts[2].should be(assignments[1])
      stmts[3].should be_a_retain("b")
      stmts[4].should be_a_release("b")
      stmts[5].should be_a_release("a")
    end
    it "should release a variable before a second assignment and not multiple times at the end" do
      assignments = [ Ast::AssignmentDef.new("a", nil), Ast::AssignmentDef.new("a", nil) ]
      method = Ast::MethodDef.with_stmts(assignments)
      @gen.update_ast method
      stmts = method.stmts 
      stmts[2].should be_a_release("a")
      stmts[3].should be(assignments[1])
      stmts[4].should be_a_retain("a")
      stmts[5].should be_a_release("a")
      method.should have(6).stmts
    end
    it "should not fail for a destructor" do
      @gen.update_ast Ast::DtorDef.new
    end
  end
end
