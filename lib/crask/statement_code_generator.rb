module CRask
  class StatementCodeGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_statements stmts
      "#{@name_gen.get_local_name(stmts[0].left)} = #{@name_gen.get_nil_name}"
    end
  end
end