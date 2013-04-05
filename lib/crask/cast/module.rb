require 'crask/cast/global_variable'

module CRask
  module CAst
    class Module
      attr_reader :includes, :global_variables, :functions
      def initialize includes, global_variables, functions
        @includes = includes
        @global_variables = global_variables
        @functions = functions
      end
    end
  end
end