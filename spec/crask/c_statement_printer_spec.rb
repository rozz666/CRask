require 'crask/c_statement_printer'

module CRask
  describe :CStatementPrinter do
    before(:each) do
      @assignment_printer = double("assignment printer")
      @return_printer = double("return printer")
      @printer = CStatementPrinter.new({ :Assignment => @assignment_printer, :Return => @return_printer })
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print assignments" do
      stmts = [ CAst::Assignment.new ]
      @assignment_printer.should_receive(:print).with(stmts[0]).and_return("STMT\n")
      @printer.print(stmts).should eql("STMT\n")
    end
    it "should print return statements" do
      stmts = [ CAst::Return.new ]
      @return_printer.should_receive(:print).with(stmts[0]).and_return("RETURN\n")
      @printer.print(stmts).should eql("RETURN\n")
    end
  end
end