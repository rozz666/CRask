require 'crask/cast/Module'

module CRask
  class CModuleBuilder
    def initialize
      @includes = []
    end
    def add_include name
      @includes << name
    end
    def build
      CAst::Module.new @includes
    end
  end
end