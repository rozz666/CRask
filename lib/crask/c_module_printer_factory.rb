require 'crask/c_module_printer'
require 'crask/c_global_variable_printer'
require 'crask/c_function_printer'
require 'crask/c_function_argument_printer'
require 'crask/c_local_variable_printer'
require 'crask/c_expression_printer'
require 'crask/c_return_printer'
require 'crask/c_call_printer'

module CRask
  class CModulePrinterFactory
    def create_module_printer
      expr_printer = CExpressionPrinter.new
      call_printer = CCallPrinter.new expr_printer
      expr_printer.call_printer = call_printer
      stmt_printer = CStatementPrinter.new({
        :Assignment =>CAssignmentPrinter.new(expr_printer),
        :Call => CCallPrinter.new(expr_printer),
        :Return => CReturnPrinter.new(expr_printer)
      })
      function_printer = CFunctionPrinter.new CFunctionArgumentPrinter.new, CLocalVariablePrinter.new, stmt_printer
      code_printer = CModulePrinter.new CIncludePrinter.new, CGlobalVariablePrinter.new, function_printer
    end
  end
end