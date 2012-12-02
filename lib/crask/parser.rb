require 'crask/ast'

module CRask
  class Parser
    def parse source
      ast = Ast.new
      ast.classes << ClassDefinition.new(source.split[1]) if source.length > 0
      ast
    end
  end
end