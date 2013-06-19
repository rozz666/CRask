module CRask
  class AutomaticReferenceCountingGenerator
    def update_ast ast
      method = ast.stmts[0].defs[0]
      stmts = []
      method.stmts.each { |a| stmts << a << Ast::RetainDef.new(a.left) }
      method.stmts = stmts
    end
  end
end
