require 'crask/parser_helper'

module CRask
  parser = ParserHelper.new
  describe Parser do
    it "should return empty AST for empty input" do
      ast = parser.parse("")

      ast.should be_a_kind_of(Ast::Ast)
      ast.stmts.should be_empty
    end
    it "should parse empty class definition" do
      stmts = parser.parse_stmts("class Abc {}")

      stmts.should have(1).item
      stmts[0].should be_a_kind_of(Ast::ClassDef)
      stmts[0].name.should eql("Abc")
      stmts[0].defs.should be_empty
    end
    it "should parse all class definitions" do
      stmts = parser.parse_stmts("class A {}\nclass B {}")

      stmts.should have(2).items
    end
    it "should parse empty method definition" do
      defs = parser.parse_class_defs("def foo {\n}");

      defs.should have(1).item
      defs[0].should be_a_kind_of(Ast::MethodDef)
      defs[0].name.should eql("foo")
    end
    it "should parse all method definitions" do
      defs = parser.parse_class_defs("def a {\n}\ndef b {\n}\n")
      
      defs.should have(2).items
    end
    it "should parse empty ctor definition" do
      defs = parser.parse_class_defs("ctor foo {\n}")
      
      defs.should have(1).item
      defs[0].should be_a_kind_of(Ast::CtorDef)
      defs[0].name.should eql("foo")
    end
    it "should parse all ctor definitions" do
      defs = parser.parse_class_defs("ctor a {\n}\ndef b {\n}\n")
      
      defs.should have(2).items
    end
  end
end