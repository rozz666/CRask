module CRask
  class CReturnPrinter
    def initialize expr_printer
      @expr_printer = expr_printer
    end
    def print ret
      "return#{print_expression(ret.expression)};\n"
    end
    private
    def print_expression expr
      return "" unless expr
      " #{@expr_printer.print(expr)}"
    end
  end
end
