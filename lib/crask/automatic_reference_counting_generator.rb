module CRask
  class AutomaticReferenceCountingGenerator
    def initialize method_updater = AutomaticReferenceCountingMethodUpdater.new
      @method_updater = method_updater
    end 
    def update_ast ast
      @method_updater.update_ast ast.stmts[0].defs[0]
    end
  end
end
