require 'crask/c_function_argument_printer'
module CRask
  describe :CFunctionArgumentPrinter do
    before(:each) do
      @printer = CFunctionArgumentPrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
  end
end
