require 'crask/c_function_argument_printer'
module CRask
  describe :CFunctionArgumentPrinter do
    before(:each) do
      @printer = CFunctionArgumentPrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print type-name pairs separated by commas" do
      args = [
        CAst::LocalVariable.new("type1", "name1"),
        CAst::LocalVariable.new("type2", "name2") ]
      @printer.print(args).should eql("type1 name1, type2 name2")
    end
  end
end
