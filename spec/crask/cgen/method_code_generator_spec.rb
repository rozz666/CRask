require 'crask/cgen/method_code_generator'
module CRask
  describe :MethodCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @arg_decl = double("arg declarator")
      @stmt_gen = double("stmt generator")
      @local_decl = double("local var declarator")
      @local_detector = double("local variable detector")
      @config = double("configuration")
      @config.stub(:object_type).and_return(:OBJECT_TYPE)
      @config.stub(:self_var).and_return(:SELF)
      @config.stub(:nil_var).and_return(:NIL)
      @gen = MethodCodeGenerator.new(@config, @name_gen, @arg_decl, @stmt_gen, @local_decl, @local_detector)
    end
    it "should generate C AST of an empty method" do
      @arg_decl.should_receive(:generate_initialization_ast).with(:SELF, [ :args ]).and_return([])
      @stmt_gen.should_receive(:generate_ast).with(:stmts).and_return([])
      @local_detector.stub(:find_local_vars).and_return([])
      @local_decl.should_receive(:generate_ast).with([ :args ]).and_return([])
      @arg_decl.should_receive(:generate_local_vars_ast).with([ :args ]).and_return([])
      @name_gen.should_receive(:get_method_name).with("ClassName", "methodName", [ :args ]).and_return("METHOD_NAME")
      @arg_decl.should_receive(:generate_function_args_ast).with(:SELF).and_return(:fargs)
      
      method = @gen.generate_ast(Ast::MethodDef.new("methodName", [ :args ], :stmts).freeze, "ClassName")
        
      method.should be_a_C_function(:OBJECT_TYPE, "METHOD_NAME")
      method.should have(1).statements
      method.statements[0].should be_a_kind_of(CAst::Return)
      method.statements[0].expression.should be_a_C_variable(:NIL)
      method.local_variables.should eql([ ])
      method.arguments.should be(:fargs)
    end
    it "should generate C AST of a method with args" do
      @arg_decl.should_receive(:generate_initialization_ast).with(:SELF, [ :args ]).and_return([ :arg_stmt1, :arg_stmt2 ])
      @stmt_gen.should_receive(:generate_ast).with(:stmts).and_return([ :stmt3, :stmt4 ])
      @local_detector.should_receive(:find_local_vars).with(:stmts).and_return([ :vars ])
      @local_decl.should_receive(:generate_ast).with([ :args, :vars ]).and_return([ :loc1, :loc2 ])
      @arg_decl.should_receive(:generate_local_vars_ast).with([ :args ]).and_return([ :loc3, :loc4 ])
      @name_gen.stub(:get_method_name)
      @arg_decl.stub(:generate_function_args_ast)
      
      method = @gen.generate_ast(Ast::MethodDef.new("methodName", [ :args ], :stmts).freeze, "ClassName")
        
      method.should have(5).statements
      method.statements[0..3].should eql([ :arg_stmt1, :arg_stmt2, :stmt3, :stmt4 ])
      method.statements[4].should be_a_kind_of(CAst::Return)
      method.local_variables.should eql([ :loc1, :loc2, :loc3, :loc4 ])
    end
  end
end
