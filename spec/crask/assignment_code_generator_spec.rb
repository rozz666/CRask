require 'crask/assignment_code_generator'
require 'crask/cast_matchers'

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
    it "should generate C AST for a nil assignment to a local variable and retain it" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      @name_gen.should_receive(:get_nil_name).and_return("NIL")
      
      stmts = @gen.generate_ast(Ast::AssignmentDef.new("a", "nil"))
      
      stmts.should have(2).statements
      assignment = stmts[0]
      assignment.should be_a_kind_of(CAst::Assignment)
      assignment.left.should be_a_C_variable("LOCAL")
      retain = stmts[1]
      retain.should be_a_C_function_call("crask_retain").with(1).arg
      retain.args[0].should be_a_C_variable("LOCAL")
    end
  end
end