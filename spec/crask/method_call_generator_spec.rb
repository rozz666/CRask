require 'crask/method_call_generator'
module CRask
  describe :MethodCallGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = MethodCallGenerator.new @name_gen
    end
    it "should generate C AST for a class method call" do
      @name_gen.should_receive(:get_class_name).with("Class").and_return(:Class)
      
      ast = @gen.generate_ast Ast::MethodCall.new("Class", "method")
      
      ast.should be_a_kind_of(CAst::FunctionCall)
      get_impl = ast.name
      get_impl.should be_a_C_function_call("crask_getMethodImplForObject").with(2).args
      get_impl.args[0].should be_a_C_string("method")
      get_impl.args[1].should be_a_C_function_call("crask_getClassObject").with(1).arg
      get_impl.args[1].args[0].should be_a_C_variable(:Class)
      
      ast.args[0].should be_a_C_function_call("crask_getClassObject").with(1).arg
      ast.args[0].args[0].should be_a_C_variable(:Class)
    end
  end
end
