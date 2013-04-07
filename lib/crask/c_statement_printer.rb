require 'crask/cast/assignment'
require 'crask/cast/return'
require 'crask/cast/function_call'

module CRask
  module CAst
    class Assignment
      def print printers
        printers[:Assignment].print self
      end
    end
    
    class Return
      def print printers
        printers[:Return].print self
      end
    end
    
    class FunctionCall
      def print printers
        printers[:FunctionCall].print self
      end
    end
  end
  
  class CStatementPrinter
    def initialize printers
      @printers = printers
    end
    def print stmts
      return "" if stmts.empty?
      stmts[0].print @printers
    end
  end
end