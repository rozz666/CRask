module CRask
  module CAst
    class Function
      attr_reader :local_variables
      def initialize local_variables
        @local_variables = local_variables
      end
    end
  end
end