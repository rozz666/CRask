require 'crask/statement_code_generator'

module CRask
  describe :StatementCodeGenerator do
    before(:each) do
      @assignment_gen = double("assignment generator")
      @gen = StatementCodeGenerator.new @assignment_gen
    end
    it "should generate assignments" do
      stmts = [ Ast::AssignmentDef.new("a", "nil"), Ast::AssignmentDef.new("b", "nil") ]
      @assignment_gen.should_receive(:generate).with(stmts[0]).and_return("A1")
      @assignment_gen.should_receive(:generate).with(stmts[1]).and_return("A2")
      @gen.generate_statements(stmts).should eql("A1A2")
    end
    it "should generate nothing when passed no statements" do
      @gen.generate_statements([]).should eql("")
    end
  end
end