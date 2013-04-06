module CRask
  module CAst
    class Function
      def self.with_type_name_and_args type, name, args
        CAst::Function.new type, name, args, nil, nil
      end
      def self.with_local_vars_and_stmts local_vars, stmts
        CAst::Function.new "", "", nil, local_vars, stmts
      end
      def self.with_local_vars local_vars
        CAst::Function.new "", "", nil, local_vars, nil
      end
      def self.with_stmts stmts
        CAst::Function.new "", "", nil, nil, stmts
      end
    end
  end
end