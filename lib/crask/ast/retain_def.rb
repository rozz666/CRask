module CRask
  module Ast
    class RetainDef
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end