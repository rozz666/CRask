module CRask
  module Ast
    class Assignment
      def self.to_var name
        self.new Identifier.new(name), nil
      end
      def self.to_var_from_var to, from
        self.new Identifier.new(to), Identifier.new(from)
      end
      def self.to_var_from to, from
        self.new Identifier.new(to), from
      end
    end
  end
end
