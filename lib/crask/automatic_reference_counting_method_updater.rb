require 'crask/ast/retain_def'
require 'crask/ast/release_def'

module CRask
  class AutomaticReferenceCountingMethodUpdater
    def update_ast method
      stmts = []
      vars = []
      method.stmts.each { |a| vars << a.left; stmts << a << Ast::RetainDef.new(a.left) }
      vars.reverse.each { |v| stmts << Ast::ReleaseDef.new(v) }
      method.stmts = stmts
    end
  end
end
