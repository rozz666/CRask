require 'crask/cgen/method_registration_generator'
module CRask
  describe :MethodRegistrationGenerator do
    before(:each) do
      @symbol_name_gen = double("symbol name generator")
      @method_name_gen = double("method name generator")

      @gen = MethodRegistrationGenerator.new @symbol_name_gen, @method_name_gen
    end
    it "should generate C AST of method registration using libcrask" do
      cdef = Ast::MethodDef.new("foo", :args, nil)
      @symbol_name_gen.should_receive(:get_method_name).with("className", "foo", :args).and_return("functionName")
      @method_name_gen.should_receive(:generate).with("foo", :args).and_return("fooName")

      method_reg = @gen.generate_ast(cdef, "className", "classVarName")
      method_reg.should be_a_C_function_call("crask_addMethodToClass").with(3).args
      method_reg.args[0].should be_a_C_variable_address("functionName")
      method_reg.args[1].should be_a_C_string("fooName")
      method_reg.args[2].should be_a_C_variable("classVarName")
    end
  end
end
