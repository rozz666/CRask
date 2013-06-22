module CRask
  module Ast
    class CtorDef
      def generate_registration_ast generators, class_name, class_var_name
        generators[:Constructor].generate_ast self, class_name, class_var_name
      end
    end
    class DtorDef
      def generate_registration_ast generators, class_name, class_var_name
        generators[:Destructor].generate_ast class_name, class_var_name
      end
    end
    class MethodDef
      def generate_registration_ast generators, class_name, class_var_name
        generators[:Method].generate_ast self, class_name, class_var_name
      end
    end
  end
  class MemberRegistrationGenerator
    def initialize generators
      @generators = generators
    end
    def generate_ast defs, class_name, class_var_name
      defs.map do |d|
        d.generate_registration_ast(@generators, class_name, class_var_name)
      end
    end
  end
end
