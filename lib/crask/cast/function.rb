module CRask
  module CAst
    class Function
      attr_reader :local_variables, :statements
      def initialize local_variables, statements
        @local_variables = local_variables
        @statements = statements 
      end
    end
  end
end