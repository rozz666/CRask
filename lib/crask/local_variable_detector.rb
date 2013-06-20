module CRask
  class LocalVariableDetector
    def find_local_variables stmts
      stmts.map { |s| s.left }
    end
  end
end
