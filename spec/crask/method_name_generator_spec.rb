require 'crask/method_name_generator'

module CRask
  describe MethodNameGenerator do
    before(:each) do
      @gen = MethodNameGenerator.new
    end
    it "should return only method name" do
      @gen.generate("foo", []).should eql("foo")
    end
  end
end