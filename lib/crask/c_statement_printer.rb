require 'crask/cast/assignment'
require 'crask/cast/return'
require 'crask/cast/function_call'

module CRask
  module CAst
    class Assignment
      def print_with printers
        printers[:Assignment].print self
      end
    end
    
    class Return
      def print_with printers
        printers[:Return].print self
      end
    end
    
    class FunctionCall
      def print_with printers
        printers[:FunctionCall].print(self) + ";\n"
      end
    end
  end
  
  class CStatementPrinter
    def initialize printers
      @printers = printers
    end
    def print stmts
      stmts.map { |s| s.print_with @printers }.join
    end
  end
end