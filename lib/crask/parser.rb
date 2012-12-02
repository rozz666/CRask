require 'crask/ast/ast'

module CRask
  class Parser
    def parse source
      ast = Ast::Ast.new
      class_name_is_next = false
      method_name_is_next = false
      source.split.each { |id|
        ast.stmts << Ast::ClassDef.new(id) if class_name_is_next
        ast.stmts[-1].method_defs << Ast::MethodDef.new(id) if method_name_is_next
        class_name_is_next = id == "class"
        method_name_is_next = id == "def"
      } 
      ast
    end
  end
end