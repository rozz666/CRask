require 'crask/automatic_reference_counting_method_updater'
module CRask
  describe :AutomaticReferenceCountingMethodUpdater do
    before(:each) do
      @gen = AutomaticReferenceCountingMethodUpdater.new
    end
    it "should retain variables after assignments and release at the end" do
      assignments = [ Ast::AssignmentDef.new("a", nil), Ast::AssignmentDef.new("b", nil) ]
      method = Ast::MethodDef.new(nil, nil, assignments)
      @gen.update_ast method
      method.should have(6).stmts
      stmts = method.stmts 
      stmts[0].should be(assignments[0])
      stmts[1].should be_a_kind_of(Ast::RetainDef)
      stmts[1].name.should eql("a")
      stmts[2].should be(assignments[1])
      stmts[3].should be_a_kind_of(Ast::RetainDef)
      stmts[3].name.should eql("b")
      stmts[4].should be_a_kind_of(Ast::ReleaseDef)
      stmts[4].name.should eql("b")
      stmts[5].should be_a_kind_of(Ast::ReleaseDef)
      stmts[5].name.should eql("a")
    end
    it "should release a variable before second assignment" do
      assignments = [ Ast::AssignmentDef.new("a", nil), Ast::AssignmentDef.new("a", nil) ]
      method = Ast::MethodDef.new(nil, nil, assignments)
      @gen.update_ast method
      stmts = method.stmts 
      stmts[2].should be_a_kind_of(Ast::ReleaseDef)
      stmts[2].name.should eql("a")
      stmts[3].should be(assignments[1])
      stmts[4].should be_a_kind_of(Ast::RetainDef)
      stmts[4].name.should eql("a")
    end
  end
end
