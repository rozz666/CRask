require 'crask/c_return_printer'
module CRask
  describe :CReturnPrinter do
    before(:each) do
      @printer = CReturnPrinter.new
    end
    it "should print 'return' only when there is no expression" do
      @printer.print(CAst::Return.new).should eql("return;\n")
    end
  end
end
