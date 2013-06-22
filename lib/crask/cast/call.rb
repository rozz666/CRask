module CRask
  module CAst
    class Call
      attr_reader :expr, :args
      def initialize expr, args
        @expr = expr
        @args = args
      end
    end
  end
end