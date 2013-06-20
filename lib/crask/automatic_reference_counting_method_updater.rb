require 'crask/ast/retain_def'
require 'crask/ast/release_def'

module CRask
  module Ast
    class MethodDef
      def add_reference_counting builder
        return if stmts.empty?
        builder.add_prolog args
        @stmts.each { |a| builder.add_assignment a }
        builder.add_epilog
        @stmts = builder.stmts
      end
    end
    class CtorDef
      def add_reference_counting builder
      end
    end
    class DtorDef
      def add_reference_counting builder
      end
    end
  end
  class AutomaticReferenceCountingMethodUpdater
    def update_ast method
      method.add_reference_counting ReferenceCountedAssignmentBuilder.new
    end
    private
    class ReferenceCountedAssignmentBuilder
      attr_reader :stmts
      def initialize
        @stmts = []
        @vars = []
      end
      def add_assignment a
        var = a.left
        if @vars.index(var)
          @stmts << Ast::ReleaseDef.new(var)
        else
          @vars << var
        end
        @stmts << a << Ast::RetainDef.new(var)
      end
      def add_prolog args
        args.each { |a| @stmts << Ast::RetainDef.new(a) }
        @vars = args.dup
      end
      def add_epilog
        @vars.reverse.each { |v| @stmts << Ast::ReleaseDef.new(v) }
      end
    end
  end
end
