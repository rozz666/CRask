require 'crask/parser/parser_helper'

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
      defs[0].args.should be_identifiers("a", "b", "c")
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
      defs[0].args.should be_identifiers("a", "b", "c")
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
      mdef = parser.parse_method_def(
        "def a {\n" +
        "  var = nil\n" +
        "}\n")
        
      mdef.stmts.should have(1).item
      mdef.stmts[0].should be_kind_of(Ast::Assignment)
      mdef.stmts[0].left.should be_an_identifier("var")
      mdef.stmts[0].right.should be_an_identifier("nil")
    end
    it "should parse all nil assignments" do
      mdef = parser.parse_method_def(
        "def a {\n" +
        "  a = nil\n" +
        "  b = nil\n" +
        "}\n")
        
      mdef.stmts.should have(2).items
    end
    it "should parse assignments from method calls with no arguments" do
      stmts = parser.parse_method_stmts("var = Class.method")
      stmts.should have(1).item
      call = stmts[0].right
      call.should be_a_kind_of(Ast::MethodCall)
      call.object.should eql("Class")
      call.method.should eql("method")
      call.should have(0).args, "args: " + call.args.inspect
    end
    it "should parse assignments from method calls with no arguments and empty parentheses" do
      stmts = parser.parse_method_stmts("var = Class.method()")
      stmts.should have(1).item
      call = stmts[0].right
      call.should be_a_kind_of(Ast::MethodCall)
      call.should have(0).args, "args: " + call.args.inspect
    end
    it "should parse assignments from method calls with arguments" do
      stmts = parser.parse_method_stmts("var = Class.method(a, b, c)")
      stmts.should have(1).item
      call = stmts[0].right
      call.should be_a_kind_of(Ast::MethodCall)
      call.should have(3).args
      call.args.should be_identifiers("a", "b", "c")
    end
  end
end
