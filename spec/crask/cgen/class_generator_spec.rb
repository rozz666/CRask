require 'crask/cgen/class_generator'
require 'crask/class_factory'
require 'crask/cast_matchers'

module CRask
  describe ClassGenerator do
    before(:each) do
      @symbol_name_gen = double("symbol name generator")
      @method_name_gen = double("method name generator")
      @method_gen = double("method code generator")
      @config = double("configuration")
      @config.stub(:class_type).and_return(:CLASS_TYPE)

      @gen = ClassGenerator.new @symbol_name_gen, @method_name_gen, @method_gen, @config
    end
    it "should generate C AST of class registration using libcrask" do
      cdef = Ast::ClassDef.with_name "A"
      @symbol_name_gen.stub(:get_class_name).with("A").and_return("name1")
      regs = @gen.generate_registration_ast(cdef)
      regs.should have(1).item
      class_reg = regs[0]
      class_reg.should be_a_kind_of(CAst::Assignment)
      class_reg.left.should be_a_C_variable("name1")
      class_reg.right.should be_a_C_function_call("crask_registerClass").with(1).arg
      class_reg.right.args[0].should be_a_C_string("A")
    end
    it "should generate C AST of destructor registration using libcrask" do
      cdef = Ast::ClassDef.with_name_and_dtor "B"
      @symbol_name_gen.stub(:get_class_name).and_return("className")
      @symbol_name_gen.stub(:get_dtor_name).with("B").and_return("dtorName")
      regs = @gen.generate_registration_ast(cdef)
      regs.should have(2).items
      regs[0].should be_a_kind_of(CAst::Assignment)
      dtor_reg = regs[1]
      dtor_reg.should be_a_C_function_call("crask_addDestructorToClass").with(2).args
      dtor_reg.args[0].should be_a_C_variable_address("dtorName")
      dtor_reg.args[1].should be_a_C_variable("className")
    end
    it "should generate C AST of method registration using libcrask" do
      cdef = Ast::ClassDef.with_name_and_methods_with_args "A", [ "abc", :args ]
      @symbol_name_gen.stub(:get_class_name).and_return("className")
      @symbol_name_gen.stub(:get_method_name).with("A", "abc", :args).and_return("methodName")
      @method_name_gen.should_receive(:generate).with("abc", :args).and_return("abcName")
      regs = @gen.generate_registration_ast(cdef)
      regs.should have(2).items
      method_reg = regs[1]
      method_reg.should be_a_C_function_call("crask_addMethodToClass").with(3).args
      method_reg.args[0].should be_a_C_variable_address("methodName")
      method_reg.args[1].should be_a_C_string("abcName")
      method_reg.args[2].should be_a_C_variable("className")
    end
    it "should generate C AST of all method registrations" do
      cdef = Ast::ClassDef.with_name_and_methods_with_args "A", [ "abc", [] ], [ "def", [] ]
      @symbol_name_gen.stub(:get_class_name)
      @symbol_name_gen.stub(:get_method_name)
      @method_name_gen.stub(:generate)

      @gen.generate_registration_ast(cdef).should have(3).items, "should have 1 class and 2 method registrations"
    end
    it "should generate constructor registrations as class methods using libcrask" do
      cdef = Ast::ClassDef.with_name_and_ctors_with_args "X", [ "foo", :args ]
      @symbol_name_gen.stub(:get_class_name).and_return("className")
      @symbol_name_gen.stub(:get_ctor_name).with("X", "foo", :args).and_return("ctorName")
      @method_name_gen.should_receive(:generate).with("foo", :args).and_return("fooName")
      regs = @gen.generate_registration_ast(cdef)
      regs.should have(2).items
      method_reg = regs[1]
      method_reg.should be_a_C_function_call("crask_addClassMethodToClass").with(3).args
      method_reg.args[0].should be_a_C_variable_address("ctorName")
      method_reg.args[1].should be_a_C_string("fooName")
      method_reg.args[2].should be_a_C_variable("className")
    end
    it "should generate class variable declaration C AST" do
      cdef = Ast::ClassDef.with_name "Z"
      @symbol_name_gen.should_receive(:get_class_name).with("Z").and_return("className")
      var = @gen.generate_declaration_ast(cdef)
      var.should be_a_kind_of(CAst::GlobalVariable)
      var.type.should eql(:CLASS_TYPE)
      var.name.should eql("className")
    end
    it "should generate method implementations C AST" do
      cdef = Ast::ClassDef.with_name_and_two_methods("A", "abc", "def")
      @method_gen.should_receive(:generate_ast).with("A", cdef.defs[0]).and_return(:impl1)
      @method_gen.should_receive(:generate_ast).with("A", cdef.defs[1]).and_return(:impl2)
      @gen.generate_method_definitions_ast(cdef).should eql([ :impl1, :impl2 ])
    end
  end
end