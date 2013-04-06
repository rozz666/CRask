require 'crask/cast/function'

module CRask
  class CFunctionBuilder
    def initialize
      @local_variables = []
    end
    def add_local_variable name
      @local_variables << name
    end
    def build
      CAst::Function.new @local_variables
    end
  end
end