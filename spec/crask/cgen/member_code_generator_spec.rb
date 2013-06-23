require 'crask/cgen/member_code_generator'
require 'crask/cgen/method_code_generator'
require 'crask/cgen/constructor_code_generator'
require 'crask/cgen/destructor_code_generator'

module CRask
  describe MemberCodeGenerator do
    before :each do
      @ctor_gen = double("constructor generator")
      @dtor_gen = double("destructor generator")
      @method_gen = double("method generator")
      @gen = MemberCodeGenerator.new({
        :Constructor => @ctor_gen,
        :Destructor => @dtor_gen,
        :Method => @method_gen
      })
    end
    it "should generate C AST of a method" do
      cdef = Ast::MethodDef.with_stmts(nil)
      @method_gen.should_receive(:generate_ast).with(cdef, "ClassName").and_return(:method)
      
      @gen.generate_ast("ClassName", cdef).should be(:method)
    end
    it "should generate C AST of a constructor" do
      cdef = Ast::CtorDef.new("ctorName", :args).freeze
      @ctor_gen.should_receive(:generate_ast).with(cdef, "ClassName").and_return(:ctor)
      
      @gen.generate_ast("ClassName", cdef).should be(:ctor)
    end
    it "should generate C AST of a destructor" do
      cdef = Ast::DtorDef.new
      @dtor_gen.should_receive(:generate_ast).with("ClassName").and_return(:dtor)
      
      @gen.generate_ast("ClassName", cdef).should be(:dtor)
    end
  end
end