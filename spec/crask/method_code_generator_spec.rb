require 'crask/method_code_generator'

module CRask
  describe MethodCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @arg_decl = double("arg declarator")
      @stmt_gen = double("stmt generator")
      @stmt_printer = double("statement printer")
      @local_decl = double("local var declarator")
      @gen = MethodCodeGenerator.new @name_gen, @arg_decl, @stmt_gen, @stmt_printer, @local_decl
    end
    it "should generate a method with args" do
      args = [ "arg1", "arg2"]
      @name_gen.should_receive(:get_method_name).with("A", "m", args).and_return("methodName")
      @name_gen.should_receive(:get_self_name).and_return("selfName")
      @arg_decl.should_receive(:generate_initialization).with("selfName", args).and_return("DECLARED_ARGS")
      @arg_decl.should_receive(:generate_function_args).with("selfName").and_return("FUNCTION_ARGS")
      @stmt_gen.should_receive(:generate_ast).with(:stmts).and_return(:stmts_ast)
      @stmt_printer.should_receive(:print).with(:stmts_ast).and_return("STATEMENTS")
      @local_decl.should_receive(:generate_variables).with(args).and_return("LOCAL_VARS")
      @gen.generate("A", Ast::MethodDef.new("m", args, :stmts)).should eql(
        "CRASK_OBJECT methodName(FUNCTION_ARGS) {\n" + 
        "LOCAL_VARS" +
        "DECLARED_ARGS" +
        "STATEMENTS" +
        "    return CRASK_NIL;\n" +
        "}\n")
    end
    it "should generate C AST of an empty method" do
      @arg_decl.should_receive(:generate_initialization_ast).with("SELF", :args).and_return([])
      @stmt_gen.should_receive(:generate_ast).with(:stmts).and_return([])
      @local_decl.should_receive(:generate_ast).with(:args).and_return([])
      @arg_decl.should_receive(:generate_local_vars_ast).with(:args).and_return([])
      @name_gen.stub(:get_self_name).and_return("SELF")
      @name_gen.stub(:get_nil_name).and_return("NIL")
      @name_gen.should_receive(:get_method_name).with("ClassName", "methodName", :args).and_return("METHOD_NAME")
      @arg_decl.should_receive(:generate_function_args_ast).with("SELF").and_return(:fargs)
      
      method = @gen.generate_ast("ClassName", Ast::MethodDef.new("methodName", :args, :stmts))
        
      method.type.should eql("CRASK_OBJECT")
      method.name.should eql("METHOD_NAME")
      method.should have(1).statements
      method.statements[0].should be_a_kind_of(CAst::Return)
      method.statements[0].expression.should be_a_C_variable("NIL")
      method.local_variables.should eql([ ])
      method.arguments.should be(:fargs)
    end
    it "should generate C AST of a method with args" do
      @arg_decl.should_receive(:generate_initialization_ast).with("SELF", :args).and_return([ :arg_stmt1, :arg_stmt2 ])
      @stmt_gen.should_receive(:generate_ast).with(:stmts).and_return([ :stmt3, :stmt4 ])
      @local_decl.should_receive(:generate_ast).with(:args).and_return([ :loc1, :loc2 ])
      @arg_decl.should_receive(:generate_local_vars_ast).with(:args).and_return([ :loc3, :loc4 ])
      @name_gen.stub(:get_self_name).and_return("SELF")
      @name_gen.stub(:get_nil_name).and_return("NIL")
      @name_gen.stub(:get_method_name)
      @arg_decl.stub(:generate_function_args_ast)
      
      method = @gen.generate_ast("ClassName", Ast::MethodDef.new("methodName", :args, :stmts))
        
      method.should have(5).statements
      method.statements[0..3].should eql([ :arg_stmt1, :arg_stmt2, :stmt3, :stmt4 ])
      method.statements[4].should be_a_kind_of(CAst::Return)
      method.local_variables.should eql([ :loc1, :loc2, :loc3, :loc4 ])
    end
    it "should generate a constructor with args creating a new instance" do
      args = [ "arg1", "arg2"]
      @name_gen.should_receive(:get_ctor_name).with("A", "m", args).and_return("ctorName")
      @name_gen.should_receive(:get_class_name).with("A").and_return("className")
      @name_gen.should_receive(:get_class_self_name).and_return("classSelfName")
      @name_gen.should_receive(:get_self_name).and_return("selfName")
      @arg_decl.should_receive(:generate_initialization).with("classSelfName", args).and_return("DECLARED_ARGS")
      @arg_decl.should_receive(:generate_function_args).with("classSelfName").and_return("FUNCTION_ARGS")
      @local_decl.should_receive(:generate_variables).with(args).and_return("LOCAL_VARS")
      @gen.generate("A", Ast::CtorDef.new("m", args)).should eql(
        "CRASK_OBJECT ctorName(FUNCTION_ARGS) {\n" +
        "LOCAL_VARS" +
        "DECLARED_ARGS" +
        "    CRASK_OBJECT selfName;\n" + 
        "    selfName = crask_createInstance(className);\n" +
        "    return selfName;\n" +
        "}\n")
    end
    it "should generate an empty destructor" do
      @name_gen.should_receive(:get_dtor_name).with("A").and_return("dtorName")
      @gen.generate("A", Ast::DtorDef.new).should eql(
        "void dtorName(CRASK_OBJECT self) {\n}\n")
    end
    it "should generate C AST of an empty destructor" do
      @name_gen.should_receive(:get_dtor_name).with("ClassName").and_return("dtorName")
      @name_gen.stub(:get_self_name).and_return("SELF")
      method = @gen.generate_ast("ClassName", Ast::DtorDef.new)
      
      method.name.should eql("dtorName")
      method.type.should eql("void")
      method.should have(1).arguments
      method.arguments[0].should be_a_local_C_variable("CRASK_OBJECT", "SELF") #TODO: multiple responsibilities
      method.should have(0).local_variables
      method.should have(0).statements
    end
  end
end