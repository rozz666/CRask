require 'crask/class_generator'
require 'crask/class_factory'

module CRask
  describe ClassGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = ClassGenerator.new @name_gen
    end
    it "should generate class registration using libcrask" do
      cdef = Ast::ClassDef.with_name "A"
      @name_gen.stub(:get_class_name).with("A").and_return("name1")
      @gen.generate_registration(cdef).should eql("name1 = crask_registerClass(\"A\");\n")
    end
    it "should register class destructor" do
      cdef = Ast::ClassDef.with_name_and_dtor "B"
      @name_gen.stub(:get_class_name).and_return("className")
      @name_gen.stub(:get_dtor_name).with("B").and_return("dtorName")
      @gen.generate_registration(cdef).should end_with(
        ";\ncrask_addDestructorToClass(&dtorName, className);\n")
    end
  end
end