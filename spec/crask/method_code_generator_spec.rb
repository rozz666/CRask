require 'crask/method_code_generator'

module CRask
  describe MethodCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @arg_decl = double("arg declarator")
      @stmt_gen = double("stmt generator")
      @local_decl = double("local var declarator")
      @gen = MethodCodeGenerator.new @name_gen, @arg_decl, @stmt_gen, @local_decl
    end
    it "should generate a method with args" do
      args = [ "arg1", "arg2"]
      @name_gen.should_receive(:get_method_name).with("A", "m", args).and_return("methodName")
      @name_gen.should_receive(:get_self_name).and_return("selfName")
      @arg_decl.should_receive(:generate_from_self_arg).with("selfName", args).and_return("DECLARED_ARGS")
      @arg_decl.should_receive(:generate_function_args).with("selfName").and_return("FUNCTION_ARGS")
      @stmt_gen.should_receive(:generate_statements).with(:stmts).and_return("STATEMENTS")
      @local_decl.should_receive(:generate_variables).with(args).and_return("LOCAL_VARS")
      @gen.generate("A", Ast::MethodDef.new("m", args, :stmts)).should eql(
        "CRASK_OBJECT methodName(FUNCTION_ARGS) {\n" + 
        "LOCAL_VARS" +
        "DECLARED_ARGS" +
        "STATEMENTS" +
        "    return CRASK_NIL;\n" +
        "}\n")
    end
    it "should generate a constructor with args creating a new instance" do
      args = [ "arg1", "arg2"]
      @name_gen.should_receive(:get_ctor_name).with("A", "m", args).and_return("ctorName")
      @name_gen.should_receive(:get_class_name).with("A").and_return("className")
      @name_gen.should_receive(:get_class_self_name).and_return("classSelfName")
      @name_gen.should_receive(:get_self_name).and_return("selfName")
      @arg_decl.should_receive(:generate_from_self_arg).with("classSelfName", args).and_return("DECLARED_ARGS")
      @arg_decl.should_receive(:generate_function_args).with("classSelfName").and_return("FUNCTION_ARGS")
      @gen.generate("A", Ast::CtorDef.new("m", args)).should eql(
        "CRASK_OBJECT ctorName(FUNCTION_ARGS) {\n" +
        "DECLARED_ARGS" +
        "    CRASK_OBJECT selfName = crask_createInstance(className);\n" +
        "    return selfName;\n" +
        "}\n")
    end
    it "should generate an empty destructor" do
      @name_gen.should_receive(:get_dtor_name).with("A").and_return("dtorName")
      @gen.generate("A", Ast::DtorDef.new).should eql(
        "void dtorName(CRASK_OBJECT self) {\n}\n")
    end
  end
end