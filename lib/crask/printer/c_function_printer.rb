module CRask
  class CFunctionPrinter
    def initialize argument_printer, local_variable_printer, statement_printer
      @argument_printer = argument_printer
      @local_variable_printer = local_variable_printer
      @statement_printer = statement_printer
    end
    def print functions
      functions.map { |f| print_function f }.join
    end
    private
    def print_function function
      args = @argument_printer.print function.arguments
      local_vars = ident_text(@local_variable_printer.print(function.local_variables))
      statements = ident_text(@statement_printer.print(function.statements))
      "#{function.type} #{function.name}(#{args}) {\n#{local_vars}#{statements}}\n"
    end
    def ident_text text
      text.split("\n").map { |line| "    " + line + "\n" }.join
    end    
  end
end