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
        "CRASK_CLASS class_A = crask_registerClass(\"A\");\n" +
        "CRASK_CLASS class_B = crask_registerClass(\"B\");\n")
      end
      it "should register class methods" do
        @ast.stmts = [ Ast::ClassDef.new("A") ]
        @ast.stmts[0].defs = [ Ast::MethodDef.new("abc"), Ast::MethodDef.new("def") ]
        @cg.generateClassRegistrations(@ast).should eql(
        "CRASK_CLASS class_A = crask_registerClass(\"A\");\n" +
        "crask_addMethodToClass(&class_A_method_abc, \"abc\", class_A);\n" +
        "crask_addMethodToClass(&class_A_method_def, \"def\", class_A);\n"
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
        @ast.stmts = [ Ast::ClassDef.new("A"), Ast::ClassDef.new("B") ]
        @cg.generateMethodDefinitions(@ast).should eql("")
      end
      it "should generate a function for each method in a class" do
        @ast.stmts = [ Ast::ClassDef.new("A") ]
        @ast.stmts[0].defs = [ Ast::MethodDef.new("abc"), Ast::MethodDef.new("def") ]
        @cg.generateMethodDefinitions(@ast).should eql(
        "CRASK_OBJECT class_A_method_abc(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n" +
        "CRASK_OBJECT class_A_method_def(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
      end
      it "should generate a function for each class" do
        @ast.stmts = [ Ast::ClassDef.new("A"), Ast::ClassDef.new("B") ]
        @ast.stmts[0].defs = [ Ast::MethodDef.new("abc") ]
        @ast.stmts[1].defs = [ Ast::MethodDef.new("def") ]
        @cg.generateMethodDefinitions(@ast).should eql(
        "CRASK_OBJECT class_A_method_abc(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n" +
        "CRASK_OBJECT class_B_method_def(CRASK_OBJECT self, ...) {\n    return CRASK_NIL;\n}\n")
      end
    end
  end
end