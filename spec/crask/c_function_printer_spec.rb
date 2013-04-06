require 'crask/c_function_printer'

module CRask
  describe :CFunctionPrinter do
    before(:each) do
      @local_variable_printer = double("local variable printer")
      @statement_printer = double("statement printer")
      @printer = CFunctionPrinter.new @local_variable_printer, @statement_printer
    end
    it "should print type and name" do
      function = CAst::Function.new "type", "name", nil, nil
      @local_variable_printer.stub(:print).and_return("")
      @statement_printer.stub(:print).and_return("")
            
      @printer.print(function).should eql("type name() {\n}\n")
    end
  end
end