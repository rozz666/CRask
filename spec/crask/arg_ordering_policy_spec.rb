require 'crask/arg_ordering_policy'

module CRask
  describe ArgOrderingPolicy do
    before(:each) do
      @policy = ArgOrderingPolicy.new
    end
    it "should sort arguments in ascending order" do
      @policy.get_ordered_arguments(["a", "b", "c"]).should eql(["a", "b", "c"])
      @policy.get_ordered_arguments(["c", "a", "b"]).should eql(["a", "b", "c"])
    end
  end
end