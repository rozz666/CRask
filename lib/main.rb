require 'crask/printer/c_module_printer_factory'
require 'crask/module_compiler_factory'

compiler = CRask::ModuleCompilerFactory.new.create
module_printer = CRask::CModulePrinterFactory.new.create_module_printer

source = File.read(ARGV[1])
c_module = compiler.compile(source)
File.open(ARGV[2], "w") do |output|
  output.write module_printer.print(c_module)
end
