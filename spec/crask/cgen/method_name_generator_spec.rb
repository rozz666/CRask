require 'crask/cgen/method_name_generator'

module CRask
  describe MethodNameGenerator do
    before(:each) do
      @arg_ordering_policy = double("arg ordering policy")
      @gen = MethodNameGenerator.new @arg_ordering_policy
    end
    it "should return method name if there are no args" do
      @gen.generate("foo", []).should eql("foo")
    end
    it "should append ordered arg list to the name" do
      @arg_ordering_policy.should_receive(:get_ordered_arguments).with([ "y", "x"]).and_return([ "x", "y" ])
      @gen.generate("bar", [ Ast.id("y"), Ast.id("x") ]).should eql("bar:x,y")
    end
  end
end