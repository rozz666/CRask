require 'crask/cast/assignment'

module CRask
  class CStatementPrinter
    def initialize assignment_printer
      @assignment_printer = assignment_printer
    end
    def print stmts
      return "" if stmts.empty?
      @assignment_printer.print stmts[0]
    end
  end
end