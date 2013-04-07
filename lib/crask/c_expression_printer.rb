require 'crask/cast/variable'
require 'crask/cast/variable_address'
require 'crask/cast/string'

module CRask
  module CAst
    class Variable
      def print
        name
      end
    end
    class VariableAddress
      def print
        "&#{name}"
      end
    end
    class String
      def print
        "\"#{value}\""
      end
    end
  end
  
  class CExpressionPrinter
    def print expr
      expr.print
    end
  end
end
