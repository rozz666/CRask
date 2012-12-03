require 'crask/code_generator'

module CRask
  describe CodeGenerator do
    before(:each) do
      @cg = CodeGenerator.new
      @ast = Ast::Ast.new
    end
    context "generateHeaders" do
      it "should include crask.h" do
        @cg.generateHeaders(@ast).should eql("#include <crask.h>\n");
      end
    end
    context "generateClassRegistrations" do
      it "should register classes and define its variables" do
        @ast.stmts = [ Ast::ClassDef.new("A"), Ast::ClassDef.new("B") ]
        @cg.generateClassRegistrations(@ast).should eql(
        "CRASK_CLASS class_A = crask_registerClass(\"A\")\n" +
        "CRASK_CLASS class_B = crask_registerClass(\"B\")\n")
      end
    end
  end
end