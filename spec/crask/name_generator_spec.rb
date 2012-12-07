require 'crask/name_generator'

module CRask
  describe NameGenerator do
    before :each do
      @generator = NameGenerator.new
    end
    context "get_class_name" do
      it "should prepend given name with class_" do
        @generator.get_class_name("name").should eql("class_name")
        @generator.get_class_name("other").should eql("class_other")
      end
    end
  end
end