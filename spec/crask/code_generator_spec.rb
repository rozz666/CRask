require 'crask/code_generator'

module CRask
  describe CodeGenerator do
    before(:each) do
      @cg = CodeGenerator.new
    end
    context "generateHeaders" do
      it "should include crask.h" do
        ast = Ast::Ast.new
        @cg.generateHeaders(ast).should eql("#include <crask.h>\n");
      end
    end
  end
end