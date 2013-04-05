module CRask
  module CAst
    class Module
      attr_reader :includes
      def initialize includes
        @includes = includes
      end
    end
  end
end