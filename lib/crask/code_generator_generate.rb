require 'crask/code_generator'

module CRask
  class CodeGenerator
    def generate ast
      generate_headers(ast) +
      generateMethodDefinitions(ast) +
      generateMainBlockBeginning(ast) +
      generate_class_registrations(ast) +
      generateMainBlockEnding(ast)
    end
  end
end