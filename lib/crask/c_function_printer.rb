module CRask
  class CFunctionPrinter
    def initialize argument_printer, local_variable_printer, statement_printer
      @argument_printer = argument_printer
      @local_variable_printer = local_variable_printer
      @statement_printer = statement_printer
    end
    def print function
      "#{function.type} #{function.name}(#{@argument_printer.print(function.arguments)}) {\n}\n"
    end
  end
end