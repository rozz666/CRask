require 'crask/code_generator'
require 'crask/ast_factory'

module CRask
  describe CodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @method_gen = double("method code generator")
      @class_gen = double("class generator")
      @cg = CodeGenerator.new(@name_gen, @method_gen, @class_gen)
      @ast = Ast::Ast.new
    end
    context "generate_headers" do
      it "should include crask.h" do
        @cg.generate_headers(@ast).should eql("#include <crask.h>\n");
      end
    end
    context "generate_class_declarations" do
      it "should generate nothing when there are no classes" do
        @cg.generate_class_declarations(@ast).should eql("")
      end
      it "should generate declarations for all classes" do
        ast = Ast::Ast.with_two_classes("A", "B")
        @class_gen.should_receive(:generate_declaration).with(ast.stmts[0]).and_return("decl1;")
        @class_gen.should_receive(:generate_declaration).with(ast.stmts[1]).and_return("decl2;")
        @cg.generate_class_declarations(ast).should eql("decl1;decl2;")
      end
    end
    context "generate_class_registrations" do
      it "should generate registrations for all classes" do
        ast = Ast::Ast.with_two_classes("A", "B")
        @class_gen.should_receive(:generate_registration).with(ast.stmts[0]).and_return("reg1;")
        @class_gen.should_receive(:generate_registration).with(ast.stmts[1]).and_return("reg2;")
        @cg.generate_class_registrations(ast).should eql("reg1;reg2;")
      end
    end
    context "generate_main_block_beginning" do
      it "should begin main()" do
        @cg.generate_main_block_beginning(@ast).should eql("int main() {\n")
      end
    end
    context "generate_main_block_ending" do
      it "should end main()" do
        @cg.generate_main_block_ending(@ast).should eql("}\n")
      end
    end
    context "generate_method_definitions" do
      it "should generate nothing when there are no classes" do
        @cg.generate_method_definitions(@ast).should eql("")
      end
      it "should generate methods for each class" do
        ast = Ast::Ast.with_two_classes("A", "B")
        @class_gen.should_receive(:generate_method_definitions).with(ast.stmts[0]).and_return("def1;")
        @class_gen.should_receive(:generate_method_definitions).with(ast.stmts[1]).and_return("def2;")
        @cg.generate_method_definitions(ast).should eql("def1;def2;")
      end
    end
  end
end