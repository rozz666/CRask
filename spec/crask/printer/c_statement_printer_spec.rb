require 'crask/printer/c_statement_printer'

module CRask
  describe :CStatementPrinter do
    before(:each) do
      @assignment_printer = double("assignment printer")
      @return_printer = double("return printer")
      @call_printer = double("call printer")
      @printer = CStatementPrinter.new({
        :Assignment => @assignment_printer,
        :Return => @return_printer,
        :Call => @call_printer })
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print assignments" do
      stmts = [ CAst::Assignment.new(nil, nil) ]
      @assignment_printer.should_receive(:print).with(stmts[0]).and_return("STMT\n")
      @printer.print(stmts).should eql("STMT\n")
    end
    it "should print return statements" do
      stmts = [ CAst::Return.new ]
      @return_printer.should_receive(:print).with(stmts[0]).and_return("RETURN\n")
      @printer.print(stmts).should eql("RETURN\n")
    end
    it "should print a function call with semicolon and newline" do
      stmts = [ CAst::Call.new(nil, nil) ]
      @call_printer.should_receive(:print).with(stmts[0]).and_return("CALL")
      @printer.print(stmts).should eql("CALL;\n")
    end
    it "should print all statements" do
      stmts = [ CAst::Assignment.new(nil, nil), CAst::Return.new, CAst::Call.new(nil, nil) ]
      @assignment_printer.should_receive(:print).with(stmts[0]).and_return("1")
      @return_printer.should_receive(:print).with(stmts[1]).and_return("2")
      @call_printer.should_receive(:print).with(stmts[2]).and_return("3")
      @printer.print(stmts).should eql("123;\n")
    end
  end
end