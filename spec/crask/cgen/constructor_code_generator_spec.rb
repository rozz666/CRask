require 'crask/cgen/constructor_code_generator'
module CRask
  describe :ConstructorCodeGenerator do
    before :each do
      @name_gen = double("name generator")
      @arg_decl = double("arg declarator")
      @stmt_gen = double("stmt generator")
      @local_decl = double("local var declarator")
      @local_detector = double("local variable detector")
      @config = double("configuration")
      @config.stub(:object_type).and_return(:OBJECT_TYPE)
      @config.stub(:self_var).and_return(:SELF)
      @config.stub(:class_self_var).and_return(:CLASS_SELF)
      @gen = ConstructorCodeGenerator.new(@config, @name_gen, @arg_decl, @stmt_gen, @local_decl, @local_detector)
    end
    it "should generate C AST of an empty constructor" do
      @arg_decl.should_receive(:generate_initialization_ast).with(:CLASS_SELF, :args).and_return([ :arg_stmt1, :arg_stmt2 ])
      @local_decl.should_receive(:generate_ast).with(:args).and_return([ :loc1, :loc2 ])
      @arg_decl.should_receive(:generate_local_vars_ast).with(:args).and_return([ :loc3, :loc4 ])
      @name_gen.should_receive(:get_class_name).with("ClassName").and_return("CLASS")
      @name_gen.should_receive(:get_ctor_name).with("ClassName", "ctorName", :args).and_return("CTOR_NAME")
      @arg_decl.should_receive(:generate_function_args_ast).with(:CLASS_SELF).and_return(:fargs)
      
      func = @gen.generate_ast(Ast::CtorDef.new("ctorName", :args).freeze, "ClassName")
       
      func.should be_a_C_function(:OBJECT_TYPE, "CTOR_NAME")
      func.should have(4).statements
      func.statements[0..1].should eql([ :arg_stmt1, :arg_stmt2 ])
      func.statements[2].should be_a_kind_of(CAst::Assignment)
      func.statements[2].left.should be_a_C_variable(:SELF)
      func.statements[2].right.should be_a_C_function_call("crask_createInstance").with(1).arg
      func.statements[2].right.args[0].should be_a_C_variable("CLASS")
      func.statements[3].should be_a_kind_of(CAst::Return)
      func.statements[3].expression.should be_a_C_variable(:SELF)
      func.local_variables[0].should be_a_local_C_variable(:OBJECT_TYPE, :SELF)
      func.local_variables[1..4].should eql([ :loc1, :loc2, :loc3, :loc4 ])
      func.arguments.should be(:fargs)
    end
  end
end
