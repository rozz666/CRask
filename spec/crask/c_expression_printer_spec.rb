require 'crask/c_expression_printer'
module CRask
  describe :CExpressionPrinter do
    before(:each) do
      @call_printer = double("call printer")
      @printer = CExpressionPrinter.new
      @printer.call_printer = @call_printer
    end
    it "should print variable name" do
      @printer.print(CAst::Variable.new("var")).should eql("var")
    end
    it "should print ampersand and variable name for address of variable" do
      @printer.print(CAst::VariableAddress.new("other")).should eql("&other")
    end
    it "should print a string in quotation marks" do
      @printer.print(CAst::String.new("a string")).should eql("\"a string\"")
    end
    it "should print a function call" do
      fc = CAst::Call.new :some, []
      @call_printer.should_receive(:print).with(fc).and_return(:printed)
      @printer.print(fc).should be(:printed)
    end
  end
end
