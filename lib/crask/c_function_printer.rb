module CRask
  class CFunctionPrinter
    def initialize local_variable_printer, statement_printer
      @local_variable_printer = local_variable_printer
      @statement_printer = statement_printer
    end
    def print function
      @local_variable_printer.print(function.local_variables) +
      @statement_printer.print(function.statements)
    end
  end
end