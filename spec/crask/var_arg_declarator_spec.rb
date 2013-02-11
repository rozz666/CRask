require 'crask/var_arg_declarator'
module CRask
  describe VarArgDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @arg_decl = VarArgDeclarator.new @name_gen
    end
    it "should declare method args using varargs" do
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      @name_gen.should_receive(:get_local_name).with("arg2").and_return("local2")
      @arg_decl.generate([ "arg1", "arg2" ]).should eql(
        "    CRASK_OBJECT local1, local2;\n" +
        "    va_list rask_args;\n" +
        "    va_start(rask_args, classSelf);\n" +
        "    local1 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    local2 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    va_end(rask_args);\n")
    end
    it "should generate nothing for no arguments" do
      @arg_decl.generate([]).should eql("")
    end
  end
end