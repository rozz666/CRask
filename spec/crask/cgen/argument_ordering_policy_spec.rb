require 'crask/cgen/argument_ordering_policy'

module CRask
  describe ArgumentOrderingPolicy do
    before(:each) do
      @policy = ArgumentOrderingPolicy.new
    end
    it "should sort arguments in ascending order" do
      @policy.get_ordered_arguments(["a", "b", "c"]).should eql(["a", "b", "c"])
      @policy.get_ordered_arguments(["c", "a", "b"]).should eql(["a", "b", "c"])
    end
  end
end