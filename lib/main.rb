require 'crask/parser'
require 'crask/code_generator_generate'

source = File.open(ARGV[1]).read
parser = CRask::Parser.new
ast = parser.parse(source)
output = File.new(ARGV[2], "w")
code_generator = CRask::CodeGenerator.new
output.write code_generator.generate(ast)
