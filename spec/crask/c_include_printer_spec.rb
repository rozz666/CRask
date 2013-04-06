require 'crask/c_include_printer'

module CRask
  describe :CIncludePrinter do
    before(:each) do
      @printer = CIncludePrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
  end
end