require 'crask/c_statement_printer'

module CRask
  describe :CStatementPrinter do
    before(:each) do
      @assignment_printer = double("assignment printer")
      @return_printer = double("return printer")
      @function_call_printer = double("function call printer")
      @printer = CStatementPrinter.new({
        :Assignment => @assignment_printer,
        :Return => @return_printer,
        :FunctionCall => @function_call_printer })
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
    it "should print function calls" do
      stmts = [ CAst::FunctionCall.new ]
      @function_call_printer.should_receive(:print).with(stmts[0]).and_return("FCALL\n")
      @printer.print(stmts).should eql("FCALL\n")
    end
  end
end