require 'crask/parser'

def genProlog(output)
  output.write("#include <crask.h>\nint main() {\n")
end

def genEpilog(output)
  output.write("}\n")
end

def genClassRegistration(output, name)
  output.write("CRASK_CLASS class_#{name} = crask_registerClass(\"#{name}\");\n")
end

source = File.open(ARGV[1]).read
parser = CRask::Parser.new
ast = parser.parse(source)
output = File.new(ARGV[2], "w")
genProlog output
ast.stmts.each { |c| genClassRegistration output, c.name }
genEpilog output