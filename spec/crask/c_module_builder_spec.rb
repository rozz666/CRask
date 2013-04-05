require 'crask/c_module_builder'

module CRask
  describe :CModuleBuilder do
    before(:each) do
      @builder = CModuleBuilder.new
    end
    it "should add includes" do
      @builder.add_include "abc"
      @builder.add_include "def"
      c_module = @builder.build
      
      c_module.should be_a_kind_of(CAst::Module)
      c_module.includes.should eql([ "abc", "def" ])
      c_module.includes.should eql([ "abc", "def" ])
    end
  end
end