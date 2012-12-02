require 'crask/ast/ast'
require 'crask/racc_parser.tab'

module CRask
  class Parser
    def initialize
      @racc_parser = RaccParser.new
    end
    def parse source
      @racc_parser.scan_str(source)
    end
  end
end