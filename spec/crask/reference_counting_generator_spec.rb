require 'crask/reference_counting_generator'
require 'crask/ast/retain_def'

module CRask
  describe :ReferenceCountingGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = ReferenceCountingGenerator.new @name_gen
    end
    it "should generate C AST for retaining a variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      stmts = @gen.generate_retain_ast(Ast::RetainDef.new("a"))
      stmts.should have(1).statement
      stmts[0].should be_a_C_function_call("crask_retain").with(1).arg
      stmts[0].args[0].should be_a_C_variable("LOCAL")
    end
    it "should generate C AST for releasing a variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      stmts = @gen.generate_release_ast(Ast::ReleaseDef.new("a"))
      stmts.should have(1).statement
      stmts[0].should be_a_C_function_call("crask_release").with(1).arg
      stmts[0].args[0].should be_a_C_variable("LOCAL")
    end
  end
end
