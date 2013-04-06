require 'crask/c_function_printer'

module CRask
  describe :CFunctionPrinter do
    before(:each) do
      @local_variable_printer = double("local variable printer")
      @statement_printer = double("statement printer")
      @printer = CFunctionPrinter.new @local_variable_printer, @statement_printer
    end
    it "should print local variables and statements" do
      function = CAst::Function.new :local_variables, :statements
      @local_variable_printer.should_receive(:print).with(:local_variables).and_return("LOCAL_VARS\n")
      @statement_printer.should_receive(:print).with(:statements).and_return("STATEMENTS\n")      
      @printer.print(function).should eql("LOCAL_VARS\nSTATEMENTS\n")
    end
  end
end