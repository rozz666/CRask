require 'crask/ast'

module CRask
  class Parser
    def parse source
      ast = Ast.new
      class_name_is_next = false
      method_name_is_next = false
      source.split.each { |id|
        ast.classes << ClassDefinition.new(id) if class_name_is_next
        ast.classes[-1].method_defs << MethodDefinition.new(id) if method_name_is_next
        class_name_is_next = id == "class"
        method_name_is_next = id == "def"
      } 
      ast
    end
  end
end