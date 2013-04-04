require 'crask/statement_code_generator'

module CRask
  describe :StatementCodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = StatementCodeGenerator.new @name_gen
    end
    it "should generate nil assignment" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      @name_gen.should_receive(:get_nil_name).and_return("NIL")
      @gen.generate_statements([ Ast::AssignmentDef.new("a", "nil") ]).should eql(
        "    LOCAL = NIL;\n" +
        "    crask_retain(LOCAL);\n")
    end
    it "should generate nothing when passed no statements" do
      @gen.generate_statements([]).should eql("")
    end
  end
end