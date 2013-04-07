module CRask
  module CAst
    class VariableAddress
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end