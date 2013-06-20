module CRask
  class LocalVariableDetector
    def find_local_vars stmts
      vars = []
      stmts.each { |s| vars << s.left if s.kind_of?(Ast::AssignmentDef) }
      vars
    end
  end
end
