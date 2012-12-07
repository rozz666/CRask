require 'crask/code_generator'
require 'crask/ast_factory'

module CRask
  describe CodeGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @cg = CodeGenerator.new(@name_gen)
      @ast = Ast::Ast.new
    end
    context "generateHeaders" do
      it "should include crask.h" do
        @cg.generateHeaders(@ast).should eql("#include <crask.h>\n");
      end
    end
    context "generateClassRegistrations" do
      it "should register classes and define its variables" do
        ast = Ast::Ast.with_two_classes("A", "B")
        @name_gen.stub(:get_class_name).with("A").and_return("name1")
        @name_gen.stub(:get_class_name).with("B").and_return("name2")
        @cg.generateClassRegistrations(ast).should eql(
        "CRASK_CLASS name1 = crask_registerClass(\"A\");\n" +
        "CRASK_CLASS name2 = crask_registerClass(\"B\");\n")
      end
      it "should register class methods" do
        ast = Ast::Ast.with_class_with_two_methods("A", "abc", "def")
        @name_gen.stub(:get_class_name).and_return("className")
        @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
        @name_gen.stub(:get_method_name).with("A", "def").and_return("methodName2")
        @cg.generateClassRegistrations(ast).should eql(
        "CRASK_CLASS className = crask_registerClass(\"A\");\n" +
        "crask_addMethodToClass(&methodName1, \"abc\", className);\n" +
        "crask_addMethodToClass(&methodName2, \"def\", className);\n"
        )
      end
    end
    context "generateMainBlockBeginning" do
      it "should begin main()" do
        @cg.generateMainBlockBeginning(@ast).should eql("int main() {\n")
      end
    end
    context "generateMainBlockEnding" do
      it "should end main()" do
        @cg.generateMainBlockEnding(@ast).should eql("}\n")
      end
    end
    context "generateMethodDefinitions" do
      it "should generate nothing when there are no classes" do
        @cg.generateMethodDefinitions(@ast).should eql("")
      end
      it "should generate nothing when there are no methods" do
        @ast = Ast::Ast.with_two_classes("A", "B")
        @cg.generateMethodDefinitions(@ast).should eql("")
      end
      it "should generate a function for each method in a class" do
        @ast = Ast::Ast.with_class_with_two_methods("A", "abc", "def")
        @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
        @name_gen.stub(:get_method_name).with("A", "def").and_return("methodName2")
        @cg.generateMethodDefinitions(@ast).should eql(
        "CRASK_OBJECT methodName1(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n" +
        "CRASK_OBJECT methodName2(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
      end
      it "should generate a function for each class" do
        @ast = Ast::Ast.with_two_classes_with_methods("A", "abc", "B", "def")
        @name_gen.stub(:get_method_name).with("A", "abc").and_return("methodName1")
        @name_gen.stub(:get_method_name).with("B", "def").and_return("methodName2")
        @cg.generateMethodDefinitions(@ast).should eql(
        "CRASK_OBJECT methodName1(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n" +
        "CRASK_OBJECT methodName2(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
      end
    end
  end
end