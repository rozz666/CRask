require 'crask/c_global_variable_printer'

module CRask
  describe :CGlobalVariablePrinter do
    before(:each) do
      @printer = CGlobalVariablePrinter.new
    end
    it "should print nothing for empty list" do
      @printer.print([]).should eql("")
    end
    it "should print C global variable declarations and append additional new line" do
      vars = [ CAst::GlobalVariable.new("type1", "name1"), CAst::GlobalVariable.new("type2", "name2") ]
      @printer.print(vars).should eql("type1 name1;\ntype2 name2;\n\n")
    end
  end
end