require 'crask/c_expression_printer'
module CRask
  describe :CExpressionPrinter do
    before(:each) do
      @printer = CExpressionPrinter.new
    end
    it "should print variable name" do
      @printer.print(CAst::Variable.new("var")).should eql("var")
    end
    it "should print ampersand and variable name for address of variable" do
      @printer.print(CAst::VariableAddress.new("other")).should eql("&other")
    end
    it "should print a string in quotation marks" do
      @printer.print(CAst::String.new("a string")).should eql("\"a string\"")
    end
  end
end
