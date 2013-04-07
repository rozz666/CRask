require 'crask/c_statement_printer'

module CRask
  describe :CStatementPrinter do
    before(:each) do
      @printer = CStatementPrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
  end
end