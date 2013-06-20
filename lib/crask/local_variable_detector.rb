module CRask
  class LocalVariableDetector
    def find_local_vars stmts
      stmts.map { |s| s.left }
    end
  end
end
