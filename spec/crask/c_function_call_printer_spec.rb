require 'crask/c_function_call_printer'
module CRask
  describe :CFunctionCallPrinter do
    before(:each) do
      @expr_printer = double("expression printer")
      @printer = CFunctionCallPrinter.new @expr_printer
    end
    it "should print function name and parens" do
      @printer.print(CAst::FunctionCall.new("func", [])).should eql("func()")
    end
    it "should print arguments" do
      @expr_printer.should_receive(:print).with(:first).and_return("FIRST")
      @expr_printer.should_receive(:print).with(:second).and_return("SECOND")
      @expr_printer.should_receive(:print).with(:third).and_return("THIRD")
      func = CAst::FunctionCall.new("func", [ :first, :second, :third ])

      @printer.print(func).should end_with("(FIRST, SECOND, THIRD)")
    end
  end
end
