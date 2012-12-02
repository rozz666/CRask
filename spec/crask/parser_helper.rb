require 'crask/parser'

module CRask
  class ParserHelper
    def initialize
      @parser = Parser.new
    end
    def parse source
      @parser.parse source
    end
    def parse_stmts source
      @parser.parse(source).stmts
    end
    def parse_class_defs source
      @parser.parse("class A {\n#{source}\n}\n").stmts[0].defs
    end
  end
end