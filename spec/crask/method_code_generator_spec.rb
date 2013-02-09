require 'crask/method_code_generator'

module CRask
  describe MethodCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @gen = MethodCodeGenerator.new @name_gen
    end
    it "should generate empty methods" do
      @name_gen.should_receive(:get_method_name).with("A", "m").and_return("methodName")
      @gen.generate("A", Ast::MethodDef.new("m")).should eql(
      "CRASK_OBJECT methodName(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
    end
    it "should generate a constructor creating a new instance" do
      @name_gen.should_receive(:get_ctor_name_with_args).with("A", "m", []).and_return("ctorName")
      @name_gen.should_receive(:get_class_name).with("A").and_return("className")
      @gen.generate("A", Ast::CtorDef.new("m", [])).should eql(
        "CRASK_OBJECT ctorName(CRASK_OBJECT classSelf, ...) {\n" +
        "    CRASK_OBJECT self = crask_createInstance(className);\n" +
        "    return self;\n" +
        "}")
    end
    it "should generate a constructor with args from varargs" do
      @name_gen.should_receive(:get_ctor_name_with_args).with("A", "m", [ "arg1", "arg2"] ).and_return("ctorName")
      @name_gen.stub(:get_class_name).and_return("className")
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      @name_gen.should_receive(:get_local_name).with("arg2").and_return("local2")
      @gen.generate("A", Ast::CtorDef.new("m", [ "arg1", "arg2" ])).should eql(
        "CRASK_OBJECT ctorName(CRASK_OBJECT classSelf, ...) {\n" +
        "    CRASK_OBJECT local1, local2;\n" +
        "    va_list rask_args;\n" +
        "    va_start(rask_args, classSelf);\n" +
        "    local1 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    local2 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    va_end(rask_args);\n" +
        "    CRASK_OBJECT self = crask_createInstance(className);\n" +
        "    return self;\n" +
        "}")
    end
    it "should generate an empty destructor" do
      @name_gen.should_receive(:get_dtor_name).with("A").and_return("dtorName")
      @gen.generate("A", Ast::DtorDef.new).should eql(
        "void dtorName(CRASK_OBJECT self) {\n}\n")
    end
  end
end