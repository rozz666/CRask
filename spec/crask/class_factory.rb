module CRask
  module Ast
    class ClassDef
      def self.with_name name
        ClassDef.new name
      end
      def self.with_name_and_dtor name
        ClassDef.new name, [ DtorDef.new ]
      end
    end
  end
end