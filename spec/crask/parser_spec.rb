require 'crask/parser'

module CRask
  describe Parser do
    it "should return empty AST for empty input" do
      ast = Parser.new.parse("")
      ast.should be_a_kind_of(Ast)
      ast.classes.should be_empty
    end
  end
end