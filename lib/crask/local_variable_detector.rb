module CRask
  class LocalVariableDetector
    def find_local_vars stmts
      vars = []
      stmts.each do |s|
        vars << s.left.name if s.kind_of?(Ast::AssignmentDef) and not vars.index(s.left.name)
      end
      vars
    end
  end
end
