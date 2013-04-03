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
    it "should parse method with args" do
      defs = parser.parse_class_defs("def foo(a, b, c) {\n}")
      
      defs[0].args.should have(3).items
      defs[0].args[0].should eql("a")
      defs[0].args[1].should eql("b")
      defs[0].args[2].should eql("c")
    end
    it "should parse empty ctor definition" do
      defs = parser.parse_class_defs("ctor foo {\n}")
      
      defs.should have(1).item
      defs[0].should be_a_kind_of(Ast::CtorDef)
      defs[0].name.should eql("foo")
    end
    it "should parse all ctor definitions" do
      defs = parser.parse_class_defs("ctor a {\n}\nctor b {\n}\n")
      
      defs.should have(2).items
    end
    it "should parse ctor definition with args" do
      defs = parser.parse_class_defs("ctor foo(a, b, c) {\n}")
      
      defs[0].args.should have(3).items
      defs[0].args[0].should eql("a")
      defs[0].args[1].should eql("b")
      defs[0].args[2].should eql("c")
    end
    it "should parse empty dtor definition" do
      defs = parser.parse_class_defs("dtor {\n}")
      
      defs.should have(1).item
      defs[0].should be_a_kind_of(Ast::DtorDef)
    end
    it "should parse all dtor definitions" do
      defs = parser.parse_class_defs("dtor {\n}\ndtor{\n}")
      
      defs.should have(2).items
    end
    it "should parse all methods in the class" do
      defs = parser.parse_class_defs(
        "def a {\n}\nctor b {\n}\ndtor {\n}\n" +
        "def c {\n}\nctor d {\n}\ndtor {\n}\n")
      
      defs.should have(6).items
    end
    it "should parse a nil assignment" do
      defs = parser.parse_class_defs(
        "def a {\n" +
        "  var = nil\n" +
        "}\n")
        
      defs[0].stmts.should have(1).item
      defs[0].stmts[0].should be_kind_of(Ast::AssignmentDef)
      defs[0].stmts[0].left.should eql("var")
      defs[0].stmts[0].right.should eql("nil")
    end
  end
end