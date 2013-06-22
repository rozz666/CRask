module CRask
  class CCallPrinter
    def initialize expr_printer
      @expr_printer = expr_printer
    end
    def print func
      "#{@expr_printer.print(func.expr)}(#{func.args.map { |a| @expr_printer.print a }.join(", ")})"
    end
  end
end
