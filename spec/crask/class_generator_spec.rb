require 'crask/class_generator'
require 'crask/class_factory'

module CRask
  describe ClassGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @method_gen = double("method code generator")
      @gen = ClassGenerator.new @name_gen, @method_gen
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
      cdef = Ast::ClassDef.with_name_and_ctors_with_args "X", [ "foo", [ "a", "b" ] ], [ "bar", [ "c" ] ]
      @name_gen.stub(:get_class_name).and_return("className")
      @name_gen.stub(:get_ctor_name_with_args).with("X", "foo", [ "a", "b" ]).and_return("ctorName1")
      @name_gen.stub(:get_ctor_name_with_args).with("X", "bar", [ "c" ]).and_return("ctorName2")
      @gen.generate_registration(cdef).should end_with(
        ";\n" +
        "crask_addClassMethodToClass(&ctorName1, \"foo\", className);\n" +
        "crask_addClassMethodToClass(&ctorName2, \"bar\", className);\n"
      )
    end
    it "should generate class variable declaration" do
      cdef = Ast::ClassDef.with_name "Z"
      @name_gen.stub(:get_class_name).and_return("className")
      @gen.generate_declaration(cdef).should eql("CRASK_CLASS className;\n")
    end
    it "should generate method implementations" do
      cdef = Ast::ClassDef.with_name_and_two_methods("A", "abc", "def")
      @method_gen.should_receive(:generate).with("A", cdef.defs[0]).and_return("impl1;")
      @method_gen.should_receive(:generate).with("A", cdef.defs[1]).and_return("impl2;")
      @gen.generate_method_definitions(cdef).should eql("impl1;impl2;")
    end
  end
end