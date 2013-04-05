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
      @builder.build.includes.should eql([ "abc", "def" ])
    end
    it "should build empty global list by default" do
      @builder.build.global_variables.should eql([])
    end
    it "should add global variables" do
      @builder.add_global_variable "type1", "var1"
      @builder.add_global_variable "type2", "var2"
      vars = @builder.build.global_variables
      vars[0].should be_a_kind_of(CAst::GlobalVariable)
      vars[0].type.should eql("type1")
      vars[0].name.should eql("var1")
      vars[1].type.should eql("type2")
      vars[1].name.should eql("var2")
    end
    it "should build empty function list by default" do
      @builder.build.functions.should eql([])
    end
    it "should add functions" do
      @builder.add_function :first
      @builder.add_function :second
      @builder.build.functions.should eql([ :first, :second ])
    end
  end
end