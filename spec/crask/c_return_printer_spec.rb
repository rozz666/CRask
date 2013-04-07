require 'crask/c_return_printer'
module CRask
  describe :CReturnPrinter do
    before(:each) do
      @expr_printer = double("expression printer")
      @printer = CReturnPrinter.new @expr_printer
    end
    it "should print 'return' only when there is no expression" do
      @printer.print(CAst::Return.new).should eql("return;\n")
    end
    it "should print the returned expression" do
      @expr_printer.should_receive(:print).with(:expression).and_return("EXPR")
      @printer.print(CAst::Return.new(:expression)).should eql("return EXPR;\n")
    end
  end
end
