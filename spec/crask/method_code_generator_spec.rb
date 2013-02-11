require 'crask/method_code_generator'

module CRask
  describe MethodCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @arg_decl = double("arg declarator")
      @gen = MethodCodeGenerator.new @name_gen, @arg_decl
    end
    it "should generate empty methods" do
      @name_gen.should_receive(:get_method_name).with("A", "m").and_return("methodName")
      @gen.generate("A", Ast::MethodDef.new("m")).should eql(
      "CRASK_OBJECT methodName(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
    end
    it "should generate a constructor with args creating a new instance" do
      args = [ "arg1", "arg2"]
      @name_gen.should_receive(:get_ctor_name).with("A", "m", args).and_return("ctorName")
      @name_gen.should_receive(:get_class_name).with("A").and_return("className")
      @arg_decl.should_receive(:generate).with(args).and_return("DECLARED_ARGS")
      @gen.generate("A", Ast::CtorDef.new("m", args)).should eql(
        "CRASK_OBJECT ctorName(CRASK_OBJECT classSelf, ...) {\n" +
        "DECLARED_ARGS" +
        "    CRASK_OBJECT self = crask_createInstance(className);\n" +
        "    return self;\n" +
        "}\n")
    end
    it "should generate an empty destructor" do
      @name_gen.should_receive(:get_dtor_name).with("A").and_return("dtorName")
      @gen.generate("A", Ast::DtorDef.new).should eql(
        "void dtorName(CRASK_OBJECT self) {\n}\n")
    end
  end
end