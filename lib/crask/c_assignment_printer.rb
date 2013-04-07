module CRask
  class CAssignmentPrinter
    def initialize expr_printer
      @expr_printer = expr_printer
    end
    def print assignment
      "#{@expr_printer.print(assignment.left)} = #{@expr_printer.print(assignment.right)};\n"
    end
  end
end