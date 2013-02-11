require 'crask/parser'
require 'crask/code_generator_factory'
require 'crask/code_generator_generate'

source = File.open(ARGV[1]) { |f| f.read }
parser = CRask::Parser.new
ast = parser.parse(source)
default_methods_generator = CRask::DefaultMethodsGenerator.new 
default_methods_generator.update_ast ast
code_generator = CRask::CodeGeneratorFactory.new.createCodeGenerator
File.open(ARGV[2], "w") { |output| output.write code_generator.generate(ast) }