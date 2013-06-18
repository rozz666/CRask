require 'crask/parser'
require 'crask/code_generator_factory'
require 'crask/c_module_printer_factory'

parser = CRask::Parser.new
default_methods_generator = CRask::DefaultMethodsGenerator.new 
code_generator = CRask::CodeGeneratorFactory.new.createCodeGenerator
module_printer = CRask::CModulePrinterFactory.new.create_module_printer

source = File.open(ARGV[1]) { |f| f.read }
ast = parser.parse(source)
default_methods_generator.update_ast ast
File.open(ARGV[2], "w") do |output|
  output.write module_printer.print(code_generator.generate_ast(ast))
end