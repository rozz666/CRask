module CRask
  class AutomaticReferenceCountingGenerator
    def initialize method_updater
      @method_updater = method_updater
    end 
    def update_ast ast
      ast.stmts.each { |s| s.defs.each { |m| @method_updater.update_ast m } }
    end
  end
end
