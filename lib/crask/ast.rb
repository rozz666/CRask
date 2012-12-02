require 'crask/class_definition'

module CRask
  class Ast
    attr_accessor :classes
    def initialize
      @classes = []
    end
  end
end