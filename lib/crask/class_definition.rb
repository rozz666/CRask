require 'crask/method_definition'

module CRask
  class ClassDefinition
    attr_reader :name
    attr_accessor :method_defs
    def initialize name
      @name = name
      @method_defs = []
    end
  end
end