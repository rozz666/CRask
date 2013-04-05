require 'crask/cast/Module'

module CRask
  class CModuleBuilder
    def initialize
      @includes = []
      @global_variables = []
    end
    def add_include name
      @includes << name
    end
    def add_global_variable type, name
      @global_variables << CAst::GlobalVariable.new(type, name)
    end
    def build
      CAst::Module.new @includes, @global_variables, []
    end
  end
end