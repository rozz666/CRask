module CRask
  module Ast
    class MethodCall
      attr_reader :object, :method
      def initialize object, method
        @object = object
        @method = method
      end
    end
  end
end