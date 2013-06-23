require 'crask/cgen/assignment_code_generator'
require 'crask/cast_matchers'
require 'crask/method_call_factory'

module CRask
 
  describe :AssignmentCodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @method_call_gen = double("method call generator")
      @config = double("configuration")
      @config.stub(:nil_var).and_return(:NIL)
      @config.stub(:nil_id).and_return(:NIL_ID)
      @gen = AssignmentCodeGenerator.new @name_gen, @config, @method_call_gen
    end
    it "should generate C AST for a nil assignment to a local variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("LOCAL")
      
      stmts = @gen.generate_ast(Ast::Assignment.to_var_from_var("a", :NIL_ID))
      
      stmts.should have(1).statement
      assignment = stmts[0]
      assignment.should be_a_kind_of(CAst::Assignment)
      assignment.left.should be_a_C_variable("LOCAL")
      assignment.right.should be_a_C_variable(:NIL)
    end
    it "should generate C AST for an assignment to a local variable from another local variable" do
      @name_gen.should_receive(:get_local_name).with("a").and_return("A")
      @name_gen.should_receive(:get_local_name).with("b").and_return("B")
      
      stmts = @gen.generate_ast(Ast::Assignment.to_var_from_var("a", "b"))
      
      stmts.should have(1).statement
      assignment = stmts[0]
      assignment.should be_a_kind_of(CAst::Assignment)
      assignment.left.should be_a_C_variable("A")
      assignment.right.should be_a_C_variable("B")
    end
    it "should generate C AST for an assignment to a local variable from a method call" do
      @name_gen.stub(:get_local_name)

      method_call = Ast::MethodCall.instance
      @method_call_gen.should_receive(:generate_ast).with(method_call).and_return(:call_ast)
      
      stmts = @gen.generate_ast(Ast::Assignment.to_var_from("a", method_call).freeze)

      assignment = stmts[0]
      assignment.right.should be(:call_ast)
    end
  end
end
