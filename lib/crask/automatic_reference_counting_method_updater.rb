module CRask
  class AutomaticReferenceCountingMethodUpdater
    def update_ast method
      stmts = []
      method.stmts.each { |a| stmts << a << Ast::RetainDef.new(a.left) }
      method.stmts = stmts
    end
  end
end
