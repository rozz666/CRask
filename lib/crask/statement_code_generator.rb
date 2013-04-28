module CRask
  class StatementCodeGenerator
    def initialize assignment_gen
      @assignment_gen = assignment_gen
    end
    def generate_statements stmts
      stmts.map { |s| @assignment_gen.generate(s) }.join
    end
    def generate_ast stmts
      stmts.map { |s| @assignment_gen.generate_ast(s) }.flatten
    end
  end
end