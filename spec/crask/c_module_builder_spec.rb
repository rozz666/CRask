require 'crask/c_module_builder'

module CRask
  describe :CModuleBuilder do
    before(:each) do
      @builder = CModuleBuilder.new
    end
    it "should build CAst::Module" do
      @builder.build.should be_a_kind_of(CAst::Module)
    end
    it "should build empty include list by default" do
      @builder.build.includes.should eql([])
    end
    it "should add includes" do
      @builder.add_include "abc"
      @builder.add_include "def"
      c_module = @builder.build.includes.should eql([ "abc", "def" ])
    end
  end
end