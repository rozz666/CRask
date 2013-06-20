require 'crask/ast/retain_def'
require 'crask/ast/release_def'

module CRask
  class AutomaticReferenceCountingMethodUpdater
    def update_ast method
      builder = ReferenceCountedAssignmentBuilder.new
      method.stmts.each { |a| builder.add_assignment a }
      builder.add_epilog
      method.stmts = builder.stmts
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
      def add_epilog
        @vars.reverse.each { |v| @stmts << Ast::ReleaseDef.new(v) }
      end
    end
  end
end
