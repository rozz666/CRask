module CRask
  module CAst
    class GlobalVariable
      attr_reader :type, :name
      def initialize type, name
        @type = type
        @name = name
      end
    end
  end
end