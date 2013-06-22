require 'crask/cgen/var_arg_declarator'
module CRask
  describe VarArgDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @config = double("configuration")
      @config.stub(:object_type).and_return(:OBJECT_TYPE)
      @config.stub(:va_list).and_return(:VA_LIST)
      
      @arg_decl = VarArgDeclarator.new @name_gen, @config
    end
    it "should generate C AST of calls to va_start and va_end for arg initialization" do
      @name_gen.stub(:get_local_name)
      stmts = @arg_decl.generate_initialization_ast("selfArg", [ "arg1" ])
      stmts.should have(3).element
      va_start = stmts[0]
      va_start.should be_a_C_function_call("va_start").with(2).args
      va_start.args[0].should be_a_C_variable(:VA_LIST)
      va_start.args[1].should be_a_C_variable("selfArg")
      va_end = stmts[2]
      va_end.should be_a_C_function_call("va_end").with(1).arg
      va_end.args[0].should be_a_C_variable(:VA_LIST)
    end
    it "should generate C AST of calls to va_arg for arg initialization" do
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      stmts = @arg_decl.generate_initialization_ast("selfArg", [ "arg1" ])
      stmts.should have(3).element
      local1 = stmts[1]
      local1.should be_a_kind_of(CAst::Assignment)
      local1.left.should be_a_C_variable("local1")
      local1.right.should be_a_C_function_call("va_arg").with(2).args
      local1.right.args[0].should be_a_C_variable(:VA_LIST)
      local1.right.args[1].should be_a_C_variable(:OBJECT_TYPE)
    end
    it "should generate C AST of calls to va_arg for all args during initialization" do
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      @name_gen.should_receive(:get_local_name).with("arg2").and_return("local2")
      stmts = @arg_decl.generate_initialization_ast("selfArg", [ "arg1", "arg2" ])
      stmts.should have(4).element
      stmts[1].left.should be_a_C_variable("local1")
      stmts[2].left.should be_a_C_variable("local2")
    end
    it "should generate C AST of rask_args declaration" do
      local_args = @arg_decl.generate_local_vars_ast [ "arg1" ]
      local_args.should have(1).item
      rask_args = local_args[0]
      rask_args.should be_a_local_C_variable("va_list", :VA_LIST)
    end
    it "should initialize nothing for no arguments" do
      @arg_decl.generate_initialization_ast("selfArg", []).should eql([])
      @arg_decl.generate_local_vars_ast([]).should eql([])
    end
    it "should generate C AST with self and varargs" do
      args = @arg_decl.generate_function_args_ast("selfName")
      args.should have(2).variables
      args[0].should be_a_local_C_variable(:OBJECT_TYPE, "selfName")
      args[1].should be_a_local_C_variable("...")
    end
  end
end