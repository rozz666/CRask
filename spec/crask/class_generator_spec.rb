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
    it "should generate destructor registration using libcrask" do
      cdef = Ast::ClassDef.with_name_and_dtor "B"
      @name_gen.stub(:get_class_name).and_return("className")
      @name_gen.stub(:get_dtor_name).with("B").and_return("dtorName")
      @gen.generate_registration(cdef).should end_with(
        ";\ncrask_addDestructorToClass(&dtorName, className);\n")
    end
    it "should generate method registrations using libcrask" do
      cdef = Ast::ClassDef.with_name_and_two_methods("A", "abc", "def")
      @name_gen.stub(:get_class_name).and_return("className")
      @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
      @name_gen.stub(:get_method_name).with("A", "def").and_return("methodName2")
      @gen.generate_registration(cdef).should end_with(
        ";\n" +
        "crask_addMethodToClass(&methodName1, \"abc\", className);\n" +
        "crask_addMethodToClass(&methodName2, \"def\", className);\n")
    end
    it "should generate constructor registrations as class methods using libcrask" do
      cdef = Ast::ClassDef.with_name_and_ctors "X", "foo", "bar"
      @name_gen.stub(:get_class_name).and_return("className")
      @name_gen.stub(:get_ctor_name).with("X", "foo").and_return("ctorName1")
      @name_gen.stub(:get_ctor_name).with("X", "bar").and_return("ctorName2")
      @gen.generate_registration(cdef).should end_with(
        ";\n" +
        "crask_addClassMethodToClass(&ctorName1, \"foo\", className);\n" +
        "crask_addClassMethodToClass(&ctorName2, \"bar\", className);\n"
      )
    end
  end
end