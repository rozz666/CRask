require 'crask/assignment_code_generator'

module CRask
  describe :AssignmentCodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @symbol_table = double("symbol table")
      @gen = AssignmentCodeGenerator.new @name_gen, @symbol_table
    end
    it "should generate nil assignment to a local variable and register the variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      @name_gen.should_receive(:get_nil_name).and_return("NIL")
      @symbol_table.should_receive(:add_local).with("a")
      @gen.generate(Ast::AssignmentDef.new("a", "nil")).should eql(
        "    LOCAL = NIL;\n" +
        "    crask_retain(LOCAL);\n")
    end
  end
end