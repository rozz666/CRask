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
    it "should group variables by type" do
      vars = [
        CAst::LocalVariable.new("A", "a1"), CAst::LocalVariable.new("A", "a2"),
        CAst::LocalVariable.new("A", "a3"), CAst::LocalVariable.new("B", "b1") ]
      text = @printer.print(vars)
      text.should include("A a1, a2, a3;")
      text.should include("B b1;")
    end
    it "should sort types alphabetically" do
      vars = [
        CAst::LocalVariable.new("C", "x"), CAst::LocalVariable.new("d", "x"),
        CAst::LocalVariable.new("A", "x"), CAst::LocalVariable.new("b", "x") ]
      text = @printer.print(vars)
      text.should match(/A[^b]*b[^C]*C[^d]*d.*/)
    end
  end
end