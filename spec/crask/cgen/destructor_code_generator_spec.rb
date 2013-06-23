require 'crask/cgen/destructor_code_generator'
module CRask
  describe :DestructorCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @config = double("configuration")
      @config.stub(:object_type).and_return(:OBJECT_TYPE)
      @config.stub(:self_var).and_return(:SELF)
      @gen = DestructorCodeGenerator.new(@config, @name_gen)
    end
    it "should generate C AST of an empty destructor" do
      @name_gen.should_receive(:get_dtor_name).with("ClassName").and_return("dtorName")
      func = @gen.generate_ast("ClassName")
      
      func.should be_a_C_function("void", "dtorName").with(1).arg
      func.arguments[0].should be_a_local_C_variable(:OBJECT_TYPE, :SELF)
      func.should have(0).local_variables
      func.should have(0).statements
    end
  end
end
