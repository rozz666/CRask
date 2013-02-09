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
      it "should prepend given name with M_ClassName_" do
        @generator.get_method_name("Y", "m1").should eql("M_Y_m1")
        @generator.get_method_name("Y", "m2").should eql("M_Y_m2")
      end
    end
    context "get_ctor_name_with_args" do
      it "should prepend given name with CT_ClassName_" do
        @generator.get_ctor_name_with_args("Abc", "c1", []).should eql("CT_Abc_c1")
      end
      it "should append arg names to generated name" do
        @generator.get_ctor_name_with_args("X", "Y", [ "a", "b", "c" ]).should eql("CT_X_Y_a_b_c")
      end
    end
    context "get_dtor_name" do
      it "should always return DT_ClassName" do
        @generator.get_dtor_name("Abc").should eql("DT_Abc")
      end
    end
    context "get_local_name" do
      it "should always return L_VarName" do
        @generator.get_local_name("xyz").should eql("L_xyz")
      end
    end
  end
end