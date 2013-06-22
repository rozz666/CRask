module CRask
  module Ast
    class Identifier
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end