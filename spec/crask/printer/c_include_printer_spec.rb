require 'crask/printer/c_include_printer'

module CRask
  describe :CIncludePrinter do
    before(:each) do
      @printer = CIncludePrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print C includes and append additional new line" do
      @printer.print([ "first", "second" ]).should eql("#include <first>\n#include <second>\n\n")
    end
  end
end