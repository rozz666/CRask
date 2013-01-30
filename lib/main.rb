require 'crask/parser'
require 'crask/code_generator_generate'
require 'crask/name_generator'
require 'crask/method_code_generator'
require 'crask/default_methods_generator'

source = File.open(ARGV[1]) { |f| f.read }
parser = CRask::Parser.new
ast = parser.parse(source)
default_methods_generator = CRask::DefaultMethodsGenerator.new 
default_methods_generator.update_ast ast
name_gen = CRask::NameGenerator.new
code_generator = CRask::CodeGenerator.new(name_gen, CRask::MethodCodeGenerator.new(name_gen))
File.open(ARGV[2], "w") { |output| output.write code_generator.generate(ast) }