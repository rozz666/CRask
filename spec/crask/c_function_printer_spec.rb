require 'crask/c_function_printer'

module CRask
  describe :CFunctionPrinter do
    before(:each) do
      @local_variable_printer = double("local variable printer")
      @statement_printer = double("statement printer")
      @arg_printer = double("arg printer")
      @printer = CFunctionPrinter.new @arg_printer, @local_variable_printer, @statement_printer
    end
    it "should print type, name and arguments" do
      function = CAst::Function.new "type", "name", :args, nil, nil
      @local_variable_printer.stub(:print).and_return("")
      @statement_printer.stub(:print).and_return("")
      @arg_printer.should_receive(:print).with(:args).and_return("ARGS")
            
      @printer.print(function).should eql("type name(ARGS) {\n}\n")
    end
  end
end