require 'crask/c_function_call_printer'
module CRask
  describe :CFunctionCallPrinter do
    before(:each) do
      @printer = CFunctionCallPrinter.new
    end
    it "should print function name and parens" do
      @printer.print(CAst::FunctionCall.new("func", [])).should eql("func()")
    end
  end
end
