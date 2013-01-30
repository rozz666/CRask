require 'crask/default_methods_generator'
require 'crask/ast_factory'

module CRask
  describe DefaultMethodsGenerator do
    before(:each) do
      @gen = DefaultMethodsGenerator.new
    end
    it "should not add a destructor to a class if it's already defined" do
      ast = Ast::Ast.with_two_classes_with_dtors
      ast.stmts[0].defs.insert 0, Ast::MethodDef.new("X")
      
      @gen.update_ast ast
      ast.stmts[0].defs.should have(2).item
      ast.stmts[1].defs.should have(1).item
    end
    it "should add a destructor to a class if it's not already defined" do
      ast = Ast::Ast.with_two_classes_with_methods("A", "b", "C", "d")
      
      @gen.update_ast ast
      ast.stmts[0].defs.should have(2).items
      ast.stmts[0].defs[1].should be_a_kind_of(Ast::DtorDef)
      ast.stmts[1].defs.should have(2).items
      ast.stmts[1].defs[1].should be_a_kind_of(Ast::DtorDef)
    end
  end
end 