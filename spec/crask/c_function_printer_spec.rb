require 'crask/c_function_printer'

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
      function = CAst::Function.new "type", "name", :args, nil, nil
      @arg_printer.should_receive(:print).with(:args).and_return("ARGS")
            
      @printer.print(function).should eql("type name(ARGS) {\n}\n")
    end
    it "should print local variables and statements" do
      function = CAst::Function.new "", "", nil, :local_vars, :statements
      @local_variable_printer.should_receive(:print).with(:local_vars).and_return("LOCAL_VARS\n")
      @statement_printer.should_receive(:print).with(:statements).and_return("STATEMENTS\n")
            
      @printer.print(function).should include("{\n    LOCAL_VARS\n    STATEMENTS\n}")
    end
    it "should ident local variables" do
      function = CAst::Function.new "", "", nil, :local_vars, nil
      @local_variable_printer.should_receive(:print).with(:local_vars).and_return("LINE1\nLINE2\n")
            
      @printer.print(function).should include("{\n    LINE1\n    LINE2\n}")
    end
    it "should ident statements" do
      function = CAst::Function.new "", "", nil, nil, :statements
      @statement_printer.should_receive(:print).with(:statements).and_return("LINE1\nLINE2\n")
            
      @printer.print(function).should include("{\n    LINE1\n    LINE2\n}")
    end
  end
end