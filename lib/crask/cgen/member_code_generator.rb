require 'crask/cast/function'
require 'crask/cast/call_facade'

module CRask
  module Ast
    class MethodDef
      def generate_ast class_name, generators
        generators[:Method].generate_ast(self, class_name)
      end
    end
    class CtorDef
      def generate_ast class_name, generators
        generators[:Constructor].generate_ast self, class_name
      end
    end
    class DtorDef
      def generate_ast class_name, generators
        generators[:Destructor].generate_ast(class_name)
      end
    end
  end
  class MemberCodeGenerator
    def initialize generators
      @generators = generators
    end
    def generate_ast class_name, method_def
      method_def.generate_ast class_name, @generators
    end
  end
end