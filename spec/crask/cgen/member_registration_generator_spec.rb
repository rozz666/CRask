require 'crask/cgen/member_registration_generator'
module CRask
  describe :MemberRegistrationGenerator do
    before(:each) do
      @ctor_gen = double("constructor generator")
      @dtor_gen = double("destructor generator")
      @method_gen = double("method generator")
      @gen = MemberRegistrationGenerator.new({
        :Constructor => @ctor_gen,
        :Destructor => @dtor_gen,
        :Method => @method_gen
      })
    end
    it "should generate nothing for no members" do
      @gen.generate_ast([], "className", "classVarName").should be_empty
    end
    it "should generate constructor registrations" do
      ctors = [ Ast::CtorDef.new(nil, nil), Ast::CtorDef.new(nil, nil) ]
      @ctor_gen.should_receive(:generate_ast).with(ctors[0], "className", "classVarName").and_return(:ctor1)
      @ctor_gen.should_receive(:generate_ast).with(ctors[1], "className", "classVarName").and_return(:ctor2)
      
      @gen.generate_ast(ctors, "className", "classVarName").should eql([ :ctor1, :ctor2 ])
    end
    it "should generate destructor registrations" do
      dtors = [ Ast::DtorDef.new, Ast::DtorDef.new ]
      @dtor_gen.should_receive(:generate_ast).with("className", "classVarName").and_return(:dtor1)
      @dtor_gen.should_receive(:generate_ast).with("className", "classVarName").and_return(:dtor2)
      
      @gen.generate_ast(dtors, "className", "classVarName").should eql([ :dtor1, :dtor2 ])
    end
    it "should generate method registrations" do
      methods = [ Ast::MethodDef.new(nil, nil, nil), Ast::MethodDef.new(nil, nil, nil) ]
      @method_gen.should_receive(:generate_ast).with(methods[0], "className", "classVarName").and_return(:method1)
      @method_gen.should_receive(:generate_ast).with(methods[1], "className", "classVarName").and_return(:method2)
      
      @gen.generate_ast(methods, "className", "classVarName").should eql([ :method1, :method2 ])
    end
  end
end
