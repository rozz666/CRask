require 'crask/c_global_variable_printer'

module CRask
  describe :CGlobalVariablePrinter do
    before(:each) do
      @printer = CGlobalVariablePrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
  end
end