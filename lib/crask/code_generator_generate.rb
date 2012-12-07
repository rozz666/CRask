require 'crask/code_generator'

module CRask
  class CodeGenerator
    def generate ast
      generate_headers(ast) +
      generateMethodDefinitions(ast) +
      generate_main_block_beginning(ast) +
      generate_class_registrations(ast) +
      generate_main_block_ending(ast)
    end
  end
end