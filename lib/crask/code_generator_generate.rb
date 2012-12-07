require 'crask/code_generator'

module CRask
  class CodeGenerator
    def generate ast
      generate_headers(ast) +
      generateMethodDefinitions(ast) +
      generateMainBlockBeginning(ast) +
      generateClassRegistrations(ast) +
      generateMainBlockEnding(ast)
    end
  end
end