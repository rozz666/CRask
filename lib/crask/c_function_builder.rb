require 'crask/cast/function'

module CRask
  class CFunctionBuilder
    def initialize
      @local_variables = []
      @statements = []
    end
    def add_local_variable name
      @local_variables << name
    end
    def add_statement stmt
      @statements << stmt
    end
    def build
      CAst::Function.new nil, nil, @local_variables, @statements
    end
  end
end