module CRask
  module Ast
    class MethodCall
      attr_reader :object, :method, :args
      def initialize object, method, args
        @object = object
        @method = method
        @args = args
      end
    end
  end
end