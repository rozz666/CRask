module CRask
  module CAst
    class Call
      def self.function name, args
        self.new CAst::Variable.new(name), args
      end
    end
  end
end