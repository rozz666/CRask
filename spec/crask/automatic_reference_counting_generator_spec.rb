require 'crask/automatic_reference_counting_generator'
module CRask
  describe :AutomaticReferenceCountingGenerator do
    before(:each) do
      @gen = AutomaticReferenceCountingGenerator.new
    end
    it "should retain a variable after an assignment" do
      assignment = Ast::AssignmentDef.new("var",nil)
      ast = Ast::Ast.new([ Ast::ClassDef.new(nil, [ Ast::MethodDef.new(nil, nil, [ assignment ]) ]) ])
      @gen.update_ast ast
      ast.stmts[0].defs[0].should have(2).stmts
      stmts = ast.stmts[0].defs[0].stmts 
      stmts[0].should be(assignment)
      stmts[1].should be_a_kind_of(Ast::RetainDef)
      stmts[1].name.should eql("var")
    end
    it "should retain variables after assignments" do
      assignments = [ Ast::AssignmentDef.new("a", nil), Ast::AssignmentDef.new("b", nil) ]
      ast = Ast::Ast.new([ Ast::ClassDef.new(nil, [ Ast::MethodDef.new(nil, nil, assignments) ]) ])
      @gen.update_ast ast
      ast.stmts[0].defs[0].should have(4).stmts
      stmts = ast.stmts[0].defs[0].stmts 
      stmts[0].should be(assignments[0])
      stmts[1].name.should eql("a")
      stmts[2].should be(assignments[1])
      stmts[3].name.should eql("b")
    end
  end
end
