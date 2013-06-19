module CRask
  module Ast
    class ReleaseDef
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end