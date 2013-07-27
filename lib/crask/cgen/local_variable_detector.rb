module CRask
  class LocalVariableDetector
    def find_local_vars stmts
      vars = []
      stmts.each do |s|
        vars << s.left if s.kind_of?(Ast::Assignment) and not vars.index{ |v| v.name == s.left.name}
      end
      vars
    end
  end
end
