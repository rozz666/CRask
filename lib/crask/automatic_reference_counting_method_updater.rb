require 'crask/ast/retain_def'
require 'crask/ast/release_def'

module CRask
  class AutomaticReferenceCountingMethodUpdater
    def update_ast method
      stmts = []
      vars = []
      method.stmts.each do |a|
        stmts << Ast::ReleaseDef.new(a.left) if vars.index(a.left) 
        vars << a.left
        stmts << a << Ast::RetainDef.new(a.left)
      end
      vars.reverse.each { |v| stmts << Ast::ReleaseDef.new(v) }
      method.stmts = stmts
    end
  end
end
