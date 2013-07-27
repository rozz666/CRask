module CRask
  class ModuleCompiler
    def initialize parser, ast_updaters, code_gen
      @parser, @ast_updaters, @code_gen = parser, ast_updaters, code_gen
    end
    def compile source
      ast = @parser.parse(source)
      @ast_updaters.each { |u| u.update_ast ast }
      @code_gen.generate_ast ast
    end
  end
end
