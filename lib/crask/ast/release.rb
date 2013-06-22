module CRask
  module Ast
    class Release
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end