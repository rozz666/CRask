require 'crask/parser'

module CRask
  parser = Parser.new
  describe Parser do
    it "should return empty AST for empty input" do
      ast = parser.parse("")
      ast.should be_a_kind_of(Ast)
      ast.classes.should be_empty
    end
    it "should parse empty class definition" do
      ast = parser.parse("class Abc {}")
      ast.should have(1).classes
      ast.classes[0].should be_a_kind_of(ClassDefinition)
      ast.classes[0].name.should eql("Abc")
    end
    it "should parse all class definitions" do
      ast = parser.parse("class A {}\nclass B {}")
      ast.should have(2).classes
    end
    it "should parse empty method definition" do
      ast = parser.parse("class A {\n def foo {\n}\n}");
      ast.classes[0].should have(1).method_defs
      ast.classes[0].method_defs[0].should be_a_kind_of(MethodDefinition)
      ast.classes[0].method_defs[0].name.should eql("foo")
    end
  end
end