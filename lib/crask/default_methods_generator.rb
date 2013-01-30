module CRask
  class DefaultMethodsGenerator
    def update_ast ast
      ast.stmts.each do |s|
        s.defs << Ast::DtorDef.new unless s.defs.index{ |d| d.kind_of? Ast::DtorDef }
      end
    end
  end
end