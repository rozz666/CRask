require 'crask/var_arg_declarator'
module CRask
  describe VarArgDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @arg_decl = VarArgDeclarator.new @name_gen
    end
    it "should declare method args using varargs with given self arg" do
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      @name_gen.should_receive(:get_local_name).with("arg2").and_return("local2")
      @arg_decl.generate_from_self_arg("selfArg", [ "arg1", "arg2" ]).should eql(
        "    CRASK_OBJECT local1, local2;\n" +
        "    va_list rask_args;\n" +
        "    va_start(rask_args, selfArg);\n" +
        "    local1 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    local2 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    va_end(rask_args);\n")
    end
    it "should declare method args using varargs" do
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      @name_gen.should_receive(:get_local_name).with("arg2").and_return("local2")
      @name_gen.should_receive(:get_self_name).and_return("selfName")
      @arg_decl.generate_method_args([ "arg1", "arg2" ]).should eql(
        "    CRASK_OBJECT local1, local2;\n" +
        "    va_list rask_args;\n" +
        "    va_start(rask_args, selfName);\n" +
        "    local1 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    local2 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    va_end(rask_args);\n")
    end
    it "should generate nothing for no arguments" do
      @arg_decl.generate_from_self_arg("selfArg", []).should eql("")
      @arg_decl.generate_method_args([]).should eql("")
    end
    it "should declare C function var args" do
      @name_gen.should_receive(:get_self_name).and_return("selfName")
      @arg_decl.generate_function_args.should eql("CRASK_OBJECT selfName, ...")
    end
    it "should declare class C function var args" do
      @name_gen.should_receive(:get_class_self_name).and_return("classSelfName")
      @arg_decl.generate_class_function_args.should eql("CRASK_OBJECT classSelfName, ...")
    end
  end
end