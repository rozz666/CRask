require 'crask/cgen/class_generator'
require 'crask/class_factory'
require 'crask/cast_matchers'

module CRask
  describe ClassGenerator do
    before(:each) do
      @symbol_name_gen = double("symbol name generator")
      @method_gen = double("method code generator")
      @member_reg_gen = double("member registration generator")
      @class_reg_gen = double("class registration generator")
      @gen = ClassGenerator.new @symbol_name_gen, @method_gen, @class_reg_gen, @member_reg_gen
    end
    it "should generate C AST of class and members registration" do
      cdef = Ast::ClassDef.new("className", :defs)
      @symbol_name_gen.should_receive(:get_class_name).with("className").and_return("classVarName")
      @class_reg_gen.should_receive(:generate_ast).with(cdef, "classVarName").and_return(:class_reg)
      @member_reg_gen.should_receive(:generate_ast).with(:defs, "className", "classVarName").and_return([ :members_reg ])

      @gen.generate_registration_ast(cdef).should eql([ :class_reg, :members_reg ])
    end
    it "should generate method implementations C AST" do
      cdef = Ast::ClassDef.with_name_and_two_methods("A", "abc", "def")
      @method_gen.should_receive(:generate_ast).with("A", cdef.defs[0]).and_return(:impl1)
      @method_gen.should_receive(:generate_ast).with("A", cdef.defs[1]).and_return(:impl2)
      @gen.generate_method_definitions_ast(cdef).should eql([ :impl1, :impl2 ])
    end
  end
end