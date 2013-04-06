module CRask
  module CAst
    class Function
      attr_reader :type, :name, :arguments, :local_variables, :statements
      def initialize type, name, arguments, local_variables, statements
        @type = type
        @name = name
        @arguments = arguments
        @local_variables = local_variables
        @statements = statements 
      end
    end
  end
end