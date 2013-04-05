require 'crask/cast/Module'

module CRask
  class CModuleBuilder
    def add_include name
      @includes ||= []
      @includes << name
    end
    def build
      CAst::Module.new @includes
    end
  end
end