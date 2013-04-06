module CRask
  class CFunctionPrinter
    def initialize argument_printer, local_variable_printer, statement_printer
      @argument_printer = argument_printer
      @local_variable_printer = local_variable_printer
      @statement_printer = statement_printer
    end
    def print function
      args = @argument_printer.print function.arguments
      local_vars = @local_variable_printer.print function.local_variables
      local_vars = "    " + local_vars unless local_vars.empty?
      statements = @statement_printer.print function.statements
      statements = "    " + statements unless statements.empty?
      "#{function.type} #{function.name}(#{args}) {\n#{local_vars}#{statements}}\n"
    end
  end
end