module CRask
  module Ast
    class Retain
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end
