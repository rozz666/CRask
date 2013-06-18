require 'crask/cast/variable'
require 'crask/cast/variable_address'
require 'crask/cast/string'

module CRask
  module CAst
    class Variable
      def print function_call_printer
        name
      end
    end
    class VariableAddress
      def print function_call_printer
        "&#{name}"
      end
    end
    class String
      def print function_call_printer
        "\"#{value}\""
      end
    end
    class FunctionCall
      def print function_call_printer
        function_call_printer.print self
      end
    end
  end
  
  class CExpressionPrinter
    attr_writer :function_call_printer
    def print expr
      expr.print @function_call_printer
    end
  end
end
