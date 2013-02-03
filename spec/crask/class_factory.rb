module CRask
  module Ast
    class ClassDef
      def self.with_name name
        ClassDef.new name
      end
    end
  end
end