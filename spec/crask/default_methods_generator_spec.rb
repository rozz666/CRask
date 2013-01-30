require 'crask/default_methods_generator'
require 'crask/ast_factory'

module CRask
  describe DefaultMethodsGenerator do
    before(:each) do
      @gen = DefaultMethodsGenerator.new
    end
    it "should not add a destructor to a class if it's already defined" do
      ast = Ast::Ast.with_two_classes_with_dtors
      @gen.update_ast ast
      ast.stmts[0].defs.should have(1).item
      ast.stmts[1].defs.should have(1).item
    end
  end
end 