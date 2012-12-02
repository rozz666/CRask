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
      ast.should be_a_kind_of(Ast)
      ast.should have(1).classes
      ast.classes[0].should be_a_kind_of(ClassDefinition)
      ast.classes[0].name.should eql("Abc")
    end
  end
end