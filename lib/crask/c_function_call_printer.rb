module CRask
  class CFunctionCallPrinter
    def initialize expr_printer
      @expr_printer = expr_printer
    end
    def print func
      "#{func.name}(#{func.args.map { |a| @expr_printer.print a }.join(", ")})"
    end
  end
end
