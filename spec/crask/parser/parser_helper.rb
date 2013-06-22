require 'crask/parser/parser'

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
    def parse_method_def source
      parse_class_defs(source)[0]
    end
    def parse_method_stmts source
      parse_method_def("def a {\n#{source}\n}\n").stmts
    end
  end
end