require 'crask/c_function_printer'
require 'crask/c_function_factory'

module CRask
  describe :CFunctionPrinter do
    before(:each) do
      @local_variable_printer = double("local variable printer")
      @local_variable_printer.stub(:print).and_return("")
      @statement_printer = double("statement printer")
      @statement_printer.stub(:print).and_return("")
      @arg_printer = double("arg printer")
      @arg_printer.stub(:print).and_return("")
      @printer = CFunctionPrinter.new @arg_printer, @local_variable_printer, @statement_printer
    end
    it "should print type, name and arguments" do
      function = CAst::Function.with_type_name_and_args "type", "name", :args
      @arg_printer.should_receive(:print).with(:args).and_return("ARGS")
            
      @printer.print([ function ]).should eql("type name(ARGS) {\n}\n")
    end
    it "should print local variables and statements" do
      function = CAst::Function.with_local_vars_and_stmts :local_vars, :statements
      @local_variable_printer.should_receive(:print).with(:local_vars).and_return("LOCAL_VARS\n")
      @statement_printer.should_receive(:print).with(:statements).and_return("STATEMENTS\n")
            
      @printer.print([ function ]).should include("{\n    LOCAL_VARS\n    STATEMENTS\n}")
    end
    it "should ident local variables" do
      function = CAst::Function.with_local_vars :local_vars
      @local_variable_printer.should_receive(:print).with(:local_vars).and_return("LINE1\nLINE2\n")
            
      @printer.print([ function ]).should include("{\n    LINE1\n    LINE2\n}")
    end
    it "should ident statements" do
      function = CAst::Function.with_stmts :statements
      @statement_printer.should_receive(:print).with(:statements).and_return("LINE1\nLINE2\n")
            
      @printer.print([ function ]).should include("{\n    LINE1\n    LINE2\n}")
    end
    it "should print all functions" do
      functions = [
        CAst::Function.with_type_name_and_args("type1", "name1", :args1),
        CAst::Function.with_type_name_and_args("type2", "name2", :args2) ]
      @arg_printer.should_receive(:print).with(:args1).and_return("ARGS1")
      @arg_printer.should_receive(:print).with(:args2).and_return("ARGS2")
            
      @printer.print(functions).should eql("type1 name1(ARGS1) {\n}\ntype2 name2(ARGS2) {\n}\n")
    end
  end
end