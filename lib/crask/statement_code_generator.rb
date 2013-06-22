module CRask
  module Ast
    class Assignment #TODO: isn't it a dispatcher?
      def generate_ast generators
        generators[:Assignment].generate_ast(self)
      end
    end
    class Retain
      def generate_ast generators
        generators[:ReferenceCounting].generate_retain_ast(self)
      end
    end
    class Release
      def generate_ast generators
        generators[:ReferenceCounting].generate_release_ast(self)
      end
    end
  end
  class StatementCodeGenerator
    def initialize generators
      @generators = generators
    end
    def generate_ast stmts
      stmts.map { |s| s.generate_ast(@generators) }.flatten
    end
  end
end
