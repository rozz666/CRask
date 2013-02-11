require 'crask/parser'
require 'crask/code_generator_factory'
require 'crask/code_generator_generate'

parser = CRask::Parser.new
default_methods_generator = CRask::DefaultMethodsGenerator.new 
code_generator = CRask::CodeGeneratorFactory.new.createCodeGenerator

source = File.open(ARGV[1]) { |f| f.read }
ast = parser.parse(source)
default_methods_generator.update_ast ast
File.open(ARGV[2], "w") { |output| output.write code_generator.generate(ast) }