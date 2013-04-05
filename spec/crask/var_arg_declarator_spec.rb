require 'crask/var_arg_declarator'
module CRask
  describe VarArgDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @symbol_table = double("symbol table")
      @arg_decl = VarArgDeclarator.new @name_gen, @symbol_table
    end
    it "should initialize method args using varargs with given self arg and register the args" do
      @name_gen.should_receive(:get_local_name).with("arg1").and_return("local1")
      @name_gen.should_receive(:get_local_name).with("arg2").and_return("local2")
      @symbol_table.should_receive(:add_local).with("arg1")
      @symbol_table.should_receive(:add_local).with("arg2")
      @arg_decl.generate_initialization("selfArg", [ "arg1", "arg2" ]).should eql(
        "    va_list rask_args;\n" +
        "    va_start(rask_args, selfArg);\n" +
        "    local1 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    local2 = va_arg(rask_args, CRASK_OBJECT);\n" +
        "    va_end(rask_args);\n")
    end
    it "should initialize nothing for no arguments" do
      @arg_decl.generate_initialization("selfArg", []).should eql("")
    end
    it "should declare C function var args" do
      @arg_decl.generate_function_args("selfName").should eql("CRASK_OBJECT selfName, ...")
    end
  end
end