module CRask
  module CAst
    class Return
      attr_reader :expression
      def initialize expression = nil
        @expression = expression
      end
    end
  end
end