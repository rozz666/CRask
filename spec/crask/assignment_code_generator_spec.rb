require 'crask/assignment_code_generator'

module CRask
  describe :AssignmentCodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = AssignmentCodeGenerator.new @name_gen
    end
    it "should generate nil assignment" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      @name_gen.should_receive(:get_nil_name).and_return("NIL")
      @gen.generate(Ast::AssignmentDef.new("a", "nil")).should eql(
        "    LOCAL = NIL;\n" +
        "    crask_retain(LOCAL);\n")
    end
  end
end