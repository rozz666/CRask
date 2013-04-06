require 'crask/c_function_builder'

module CRask
  describe :CFunctionBuilder do
    before(:each) do
      @builder = CFunctionBuilder.new
    end
    it "should build CAst::Function" do
      @builder.build().should be_a_kind_of(CAst::Function)
    end
    it "should build empty local variable list by default" do
      @builder.build.local_variables.should eql([])
    end
    it "should add local variables" do
      @builder.add_local_variable "x"
      @builder.add_local_variable "y"
      @builder.build.local_variables.should eql([ "x", "y" ])
    end
    it "should build empty statement list build default" do
      @builder.build.statements.should eql([])
    end
    it "should add statements" do
      @builder.add_statement :first
      @builder.add_statement :second
      @builder.build.statements.should eql([ :first, :second ])
    end
  end
end