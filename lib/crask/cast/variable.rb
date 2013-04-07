module CRask
  module CAst
    class Variable
      attr_reader :name
      def initialize name
        @name = name
      end
    end
  end
end