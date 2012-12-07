require 'crask/code_generator'
require 'crask/ast_factory'

module CRask
  describe CodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @method_gen = double("method code generator")
      @cg = CodeGenerator.new(@name_gen, @method_gen)
      @ast = Ast::Ast.new
    end
    context "generate_headers" do
      it "should include crask.h" do
        @cg.generate_headers(@ast).should eql("#include <crask.h>\n");
      end
    end
    context "generate_class_registrations" do
      it "should register classes and define its variables" do
        ast = Ast::Ast.with_two_classes("A", "B")
        @name_gen.stub(:get_class_name).with("A").and_return("name1")
        @name_gen.stub(:get_class_name).with("B").and_return("name2")
        @cg.generate_class_registrations(ast).should eql(
        "CRASK_CLASS name1 = crask_registerClass(\"A\");\n" +
        "CRASK_CLASS name2 = crask_registerClass(\"B\");\n")
      end
      it "should register class methods" do
        ast = Ast::Ast.with_class_with_two_methods("A", "abc", "def")
        @name_gen.stub(:get_class_name).and_return("className")
        @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
        @name_gen.stub(:get_method_name).with("A", "def").and_return("methodName2")
        @cg.generate_class_registrations(ast).should eql(
        "CRASK_CLASS className = crask_registerClass(\"A\");\n" +
        "crask_addMethodToClass(&methodName1, \"abc\", className);\n" +
        "crask_addMethodToClass(&methodName2, \"def\", className);\n"
        )
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
      it "should generate nothing when there are no methods" do
        @ast = Ast::Ast.with_two_classes("A", "B")
        @cg.generate_method_definitions(@ast).should eql("")
      end
      it "should generate a function for each method in a class" do
        @ast = Ast::Ast.with_class_with_two_methods("A", "abc", "def")
        @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
        @name_gen.stub(:get_method_name).with("A", "def").and_return("methodName2")
        @method_gen.should_receive(:generate).with("A", @ast.stmts[0].defs[0]).and_return("method0")
        @method_gen.should_receive(:generate).with("A", @ast.stmts[0].defs[1]).and_return("method1")
        @cg.generate_method_definitions(@ast).should eql("method0method1")
      end
      it "should generate a function for each class" do
        @ast = Ast::Ast.with_two_classes_with_methods("A", "abc", "B", "def")
        @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
        @name_gen.stub(:get_method_name).with("B", "def").and_return("methodName2")
        @method_gen.should_receive(:generate).with("A", @ast.stmts[0].defs[0]).and_return("method0")
        @method_gen.should_receive(:generate).with("B", @ast.stmts[1].defs[0]).and_return("method1")
        @cg.generate_method_definitions(@ast).should eql("method0method1")
      end
    end
  end
end