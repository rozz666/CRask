require 'crask/method_code_generator'

module CRask
  describe MethodCodeGenerator do
    it "should generate empty methods" do
      name_gen = double("name generator")
      gen = MethodCodeGenerator.new name_gen
      name_gen.should_receive(:get_method_name).with("A", "m").and_return("methodName")
      gen.generate("A", Ast::MethodDef.new("m")).should eql(
      "CRASK_OBJECT methodName(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
    end
  end
end