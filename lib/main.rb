require 'crask/parser'
require 'crask/code_generator_generate'

source = File.open(ARGV[1]) { |f| f.read }
parser = CRask::Parser.new
ast = parser.parse(source)
code_generator = CRask::CodeGenerator.new
File.open(ARGV[2], "w") { |output| output.write code_generator.generate(ast) }