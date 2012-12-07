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
    context "get_method_name" do
      it "should prepend given name with GeneratedClassName_method_" do
        class_name = @generator.get_class_name("Class")
        @generator.get_method_name("Class", "m1").should eql("#{class_name}_method_m1")
        @generator.get_method_name("Class", "m2").should eql("#{class_name}_method_m2")
      end
    end
  end
end