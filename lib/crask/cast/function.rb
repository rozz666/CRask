module CRask
  module CAst
    class Function
      attr_reader :type, :name, :local_variables, :statements
      def initialize type, name, local_variables, statements
        @type = type
        @name = name
        @local_variables = local_variables
        @statements = statements 
      end
    end
  end
end