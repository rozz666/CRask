require 'crask/c_local_variable_printer'
require 'crask/cast/local_variable'

module CRask
  describe :CLocalVariablePrinter do
    before(:each) do
      @printer = CLocalVariablePrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print variables" do
      vars = [ CAst::LocalVariable.new("type1", "var1"), CAst::LocalVariable.new("type2", "var2")]
      text = @printer.print(vars)
      text.should start_with("type")
      text.should include("type1 var1;\n")
      text.should include("type2 var2;\n")
      text.should end_with(";\n")
    end
  end
end