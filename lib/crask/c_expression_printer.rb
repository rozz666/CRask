require 'crask/cast/variable'
require 'crask/cast/variable_address'
require 'crask/cast/string'

module CRask
  module CAst
    class Variable
      def print call_printer
        name
      end
    end
    class VariableAddress
      def print call_printer
        "&#{name}"
      end
    end
    class String
      def print call_printer
        "\"#{value}\""
      end
    end
    class Call
      def print call_printer
        call_printer.print self
      end
    end
  end
  
  class CExpressionPrinter
    attr_writer :call_printer
    def print expr
      expr.print @call_printer
    end
  end
end
