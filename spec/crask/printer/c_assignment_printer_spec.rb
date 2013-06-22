require 'crask/printer/c_assignment_printer'

module CRask
  describe :CAssignmentPrinter do
    before(:each) do
      @expr_printer = double("expression printer")
      @printer = CAssignmentPrinter.new @expr_printer
    end
    it "should print left and right expressions separated by assignment operator" do
      @expr_printer.should_receive(:print).with(:left).and_return("LEFT")
      @expr_printer.should_receive(:print).with(:right).and_return("RIGHT")
      @printer.print(CAst::Assignment.new(:left, :right)).should eql("LEFT = RIGHT;\n")
    end
  end
end