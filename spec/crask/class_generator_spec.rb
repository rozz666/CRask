require 'crask/class_generator'
require 'crask/class_factory'

require 'crask/method_name_generator'

module CRask
  describe ClassGenerator do
    before(:each) do
      @symbol_name_gen = double("symbol name generator")
      @method_name_gen = double("method name generator")
      @method_gen = double("method code generator")
      @gen = ClassGenerator.new @symbol_name_gen, @method_name_gen, @method_gen
    end
    it "should generate class registration using libcrask" do
      cdef = Ast::ClassDef.with_name "A"
      @symbol_name_gen.stub(:get_class_name).with("A").and_return("name1")
      @gen.generate_registration(cdef).should eql("name1 = crask_registerClass(\"A\");\n")
    end
    it "should generate destructor registration using libcrask" do
      cdef = Ast::ClassDef.with_name_and_dtor "B"
      @symbol_name_gen.stub(:get_class_name).and_return("className")
      @symbol_name_gen.stub(:get_dtor_name).with("B").and_return("dtorName")
      @gen.generate_registration(cdef).should end_with(
        ";\ncrask_addDestructorToClass(&dtorName, className);\n")
    end
    it "should generate method registrations using libcrask" do
      cdef = Ast::ClassDef.with_name_and_two_methods("A", "abc", "def")
      @symbol_name_gen.stub(:get_class_name).and_return("className")
      @symbol_name_gen.stub(:get_method_name_without_args).with("A", "abc").and_return("methodName1")
      @symbol_name_gen.stub(:get_method_name_without_args).with("A", "def").and_return("methodName2")
      @gen.generate_registration(cdef).should end_with(
        ";\n" +
        "crask_addMethodToClass(&methodName1, \"abc\", className);\n" +
        "crask_addMethodToClass(&methodName2, \"def\", className);\n")
    end
    it "should generate constructor registrations as class methods using libcrask" do
      cdef = Ast::ClassDef.with_name_and_ctors_with_args "X", [ "foo", [ "a", "b" ] ], [ "bar", [ "c" ] ]
      @symbol_name_gen.stub(:get_class_name).and_return("className")
      @symbol_name_gen.stub(:get_ctor_name).with("X", "foo", [ "a", "b" ]).and_return("ctorName1")
      @symbol_name_gen.stub(:get_ctor_name).with("X", "bar", [ "c" ]).and_return("ctorName2")
      @method_name_gen.should_receive(:generate).with("foo", [ "a", "b" ]).and_return("fooName")
      @method_name_gen.should_receive(:generate).with("bar", [ "c" ]).and_return("barName")
      @gen.generate_registration(cdef).should end_with(
        ";\n" +
        "crask_addClassMethodToClass(&ctorName1, \"fooName\", className);\n" +
        "crask_addClassMethodToClass(&ctorName2, \"barName\", className);\n"
      )
    end
    it "should generate class variable declaration" do
      cdef = Ast::ClassDef.with_name "Z"
      @symbol_name_gen.stub(:get_class_name).and_return("className")
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