require 'crask/cgen/destructor_registration_generator'
module CRask
  describe :DestructorRegistrationGenerator do
    before(:each) do
      @symbol_name_gen = double("symbol name generator")
      @gen = DestructorRegistrationGenerator.new @symbol_name_gen
    end
    it "should generate C AST of destructor registration using libcrask" do
      @symbol_name_gen.should_receive(:get_dtor_name).with("className").and_return("dtorName")

      dtor_reg = @gen.generate_ast("className", "classVarName")
      dtor_reg.should be_a_C_function_call("crask_addDestructorToClass").with(2).args
      dtor_reg.args[0].should be_a_C_variable_address("dtorName")
      dtor_reg.args[1].should be_a_C_variable("classVarName")
    end
  end
end
