module CRask
  class AutomaticReferenceCountingGenerator
    def update_ast ast
      ast.stmts[0].defs[0].stmts << Ast::RetainDef.new(ast.stmts[0].defs[0].stmts[0].left)
    end
  end
end
