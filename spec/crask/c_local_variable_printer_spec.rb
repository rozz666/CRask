require 'crask/c_local_variable_printer'

module CRask
  describe :CLocalVariablePrinter do
    before(:each) do
      @printer = CLocalVariablePrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
  end
end