require 'crask/c_expression_printer'
module CRask
  describe :CExpressionPrinter do
    before(:each) do
      @printer = CExpressionPrinter.new
    end
    it "should print variable name" do
      @printer.print(CAst::Variable.new("var")).should eql("var")
    end
  end
end
