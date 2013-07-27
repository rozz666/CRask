module CRask
  module Ast
    class Identifier
      attr_reader :name
      def initialize name
        @name = name
      end
    end
    
    def self.id name
      Identifier.new name
    end
    
    def self.ids *names
      names.map { |name| id(name) }
    end
  end
end