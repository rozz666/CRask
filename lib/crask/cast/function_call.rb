module CRask
  module CAst
    class FunctionCall
      attr_reader :name, :args
      def initialize name, args
        @name = name
        @args = args
      end
    end
  end
end