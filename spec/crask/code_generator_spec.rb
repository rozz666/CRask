require 'crask/code_generator'

module CRask
  describe CodeGenerator do
    before(:each) do
      @cg = CodeGenerator.new
    end
    it "should generate main() and include crask.h" do
      ast = Ast::Ast.new
      @cg.generate(ast).should eql("#include <crask.h>\nint main() {\n}\n");
    end
  end
end