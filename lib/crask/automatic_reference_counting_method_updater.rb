require 'crask/ast/retain'
require 'crask/ast/release'

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
        var = a.left.name
        if @vars.index(var)
          @stmts << Ast::Release.new(var)
        else
          @vars << var
        end
        @stmts << a
        @stmts << Ast::Retain.new(var) unless a.right.kind_of?(Ast::MethodCall)
      end
      def add_prolog args
        args.each { |a| @stmts << Ast::Retain.new(a) }
        @vars = args.dup
      end
      def add_epilog
        @vars.reverse.each { |v| @stmts << Ast::Release.new(v) }
      end
    end
  end
end
