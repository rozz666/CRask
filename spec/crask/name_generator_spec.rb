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
      it "should prepend given name with class_ClassName_class_method_" do
        @generator.get_method_name("Y", "m1").should eql("class_Y_class_method_m1")
        @generator.get_method_name("Y", "m2").should eql("class_Y_class_method_m2")
      end
    end
    context "get_ctor_name" do
      it "should prepend given name with class_ClassName_class_ctor_" do
        @generator.get_ctor_name("Abc", "c1").should eql("class_Abc_class_ctor_c1")
      end
    end
    context "get_dtor_name" do
      it "should always return class_ClassName_class_dtor" do
        @generator.get_dtor_name("Abc").should eql("class_Abc_class_dtor")
      end
    end
  end
end