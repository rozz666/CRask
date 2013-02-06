require 'crask/name_generator'

module CRask
  describe NameGenerator do
    before :each do
      @generator = NameGenerator.new
    end
    context "get_class_name" do
      it "should prepend given name with C_" do
        @generator.get_class_name("name").should eql("C_name")
        @generator.get_class_name("other").should eql("C_other")
      end
    end
    context "get_method_name" do
      it "should prepend given name with class_ClassName_class_method_" do
        @generator.get_method_name("Y", "m1").should eql("M_Y_m1")
        @generator.get_method_name("Y", "m2").should eql("M_Y_m2")
      end
    end
    context "get_ctor_name" do
      it "should prepend given name with class_ClassName_class_ctor_" do
        @generator.get_ctor_name("Abc", "c1").should eql("class_Abc_class_ctor_c1")
      end
    end
    context "get_dtor_name" do
      it "should always return DT_ClassName" do
        @generator.get_dtor_name("Abc").should eql("DT_Abc")
      end
    end
  end
end