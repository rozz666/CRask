require 'crask/c_statement_printer'

module CRask
  describe :CStatementPrinter do
    before(:each) do
      @assignment_printer = double("assignment printer")
      @printer = CStatementPrinter.new @assignment_printer
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print assignments" do
      stmts = [ CAst::Assignment.new ]
      @assignment_printer.should_receive(:print).with(stmts[0]).and_return("STMT\n")
      @printer.print(stmts).should eql("STMT\n")
    end
  end
end