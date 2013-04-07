require 'crask/cast/variable'
require 'crask/cast/variable_address'

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
  end
  
  class CExpressionPrinter
    def print expr
      expr.print
    end
  end
end
