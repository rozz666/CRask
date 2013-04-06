require 'crask/c_module_printer'

module CRask
  describe :CModulePrinter do
    before(:each) do
      @include_printer = double("include printer")
      @global_variable_printer = double("global variable printer")
      @function_printer = double("function printer")
      @printer = CModulePrinter.new @include_printer, @global_variable_printer, @function_printer
    end
    it "should print includes, global variables and functions" do
      @include_printer.should_receive(:print).with(:includes).and_return("INCLUDES\n")
      @global_variable_printer.should_receive(:print).with(:global_variables).and_return("GLOBALS\n")
      @function_printer.should_receive(:print).with(:functions).and_return("FUNCTIONS\n")
      
      @printer.print(CAst::Module.new(:includes, :global_variables,:functions)).should eql("INCLUDES\nGLOBALS\nFUNCTIONS\n")
    end
  end
end