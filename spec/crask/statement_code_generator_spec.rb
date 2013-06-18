require 'crask/statement_code_generator'

module CRask
  describe :StatementCodeGenerator do
    before(:each) do
      @assignment_gen = double("assignment generator")
      @gen = StatementCodeGenerator.new @assignment_gen
    end
    it "should generate nothing when passed no statements" do
      @gen.generate_ast([]).should eql([])
    end
    it "should generate C AST for assignments" do
      stmts = [ Ast::AssignmentDef.new("a", "nil"), Ast::AssignmentDef.new("b", "nil") ]
      @assignment_gen.should_receive(:generate_ast).with(stmts[0]).and_return([ :a, :b ])
      @assignment_gen.should_receive(:generate_ast).with(stmts[1]).and_return([ :c, :d ])
      @gen.generate_ast(stmts).should eql([ :a, :b, :c, :d ])
    end
  end
end