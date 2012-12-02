require 'crask/parser'

module CRask
  parser = Parser.new
  describe Parser do
    it "should return empty AST for empty input" do
      ast = parser.parse("")
      ast.should be_a_kind_of(Ast::Ast)
      ast.stmts.should be_empty
    end
    it "should parse empty class definition" do
      ast = parser.parse("class Abc {}")
      ast.should have(1).stmts
      ast.stmts[0].should be_a_kind_of(Ast::ClassDef)
      ast.stmts[0].name.should eql("Abc")
    end
    it "should parse all class definitions" do
      ast = parser.parse("class A {}\nclass B {}")
      ast.should have(2).stmts
    end
    it "should parse empty method definition" do
      ast = parser.parse("class A {\n def foo {\n}\n}");
      ast.stmts[0].should have(1).defs
      ast.stmts[0].defs[0].should be_a_kind_of(Ast::MethodDef)
      ast.stmts[0].defs[0].name.should eql("foo")
    end
  end
end