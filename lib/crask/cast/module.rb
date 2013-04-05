require 'crask/cast/global_variable'

module CRask
  module CAst
    class Module
      attr_reader :includes, :global_variables
      def initialize includes, global_variables
        @includes = includes
        @global_variables = global_variables
      end
    end
  end
end