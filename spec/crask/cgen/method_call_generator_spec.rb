require 'crask/cgen/method_call_generator'
module CRask
  describe :MethodCallGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @config = double("configuration")
      @config.stub(:nil_var).and_return(:NIL)
      @config.stub(:nil_id).and_return(:NIL_ID)
      @gen = MethodCallGenerator.new @config, @name_gen
    end
    it "should generate C AST for a class method call" do
      @name_gen.should_receive(:get_class_name).with("Class").and_return(:Class)
      
      ast = @gen.generate_ast Ast::MethodCall.new("Class", "method", [])
      
      ast.should be_a_kind_of(CAst::Call)
      get_impl = ast.expr
      get_impl.should be_a_C_function_call("crask_getMethodImplForObject").with(2).args
      get_impl.args[0].should be_a_C_string("method")
      get_impl.args[1].should be_a_C_function_call("crask_getClassObject").with(1).arg
      get_impl.args[1].args[0].should be_a_C_variable(:Class)
      
      ast.args[0].should be_a_C_function_call("crask_getClassObject").with(1).arg
      ast.args[0].args[0].should be_a_C_variable(:Class)
    end
    it "should generate C AST for nil call parameters" do
      @name_gen.should_receive(:get_class_name).with("Class").and_return(:Class)
      
      ast = @gen.generate_ast Ast::MethodCall.new("Class", "method", [ :NIL_ID, :NIL_ID ])
      
      ast.should be_a_kind_of(CAst::Call)
      ast.should have(3).args
      ast.args[1].should be_a_C_variable(:NIL)
      ast.args[2].should be_a_C_variable(:NIL)
    end
  end
end
