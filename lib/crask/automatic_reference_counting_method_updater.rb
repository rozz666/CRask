require 'crask/ast/retain_def'
require 'crask/ast/release_def'

module CRask
  class AutomaticReferenceCountingMethodUpdater
    def update_ast method
      stmts = []
      vars = []
      method.stmts.each do |a|
        var = a.left
        if vars.index(var)
          stmts << Ast::ReleaseDef.new(var)
        else
          vars << var
        end
        stmts << a << Ast::RetainDef.new(var)
      end
      vars.reverse.each { |v| stmts << Ast::ReleaseDef.new(v) }
      method.stmts = stmts
    end
  end
end
