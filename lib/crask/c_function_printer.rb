module CRask
  class CFunctionPrinter
    def initialize local_variable_printer, statement_printer
      @local_variable_printer = local_variable_printer
      @statement_printer = statement_printer
    end
    def print function
      "#{function.type} #{function.name}() {\n}\n"
    end
  end
end