require 'crask/c_function_builder'

module CRask
  describe :CFunctionBuilder do
    before(:each) do
      @builder = CFunctionBuilder.new
    end
    it "should build CAst::Function" do
      @builder.build().should be_a_kind_of(CAst::Function)
    end
  end
end