module CRask
  class CModulePrinter
    def initialize include_printer, global_variable_printer, function_printer
      @include_printer = include_printer
      @global_variable_printer = global_variable_printer
      @function_printer = function_printer
    end
    def print c_module
      @include_printer.print(c_module.includes) +
      @global_variable_printer.print(c_module.global_variables) +
      @function_printer.print(c_module.functions)
    end
  end
end