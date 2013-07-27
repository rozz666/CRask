require 'crask/module_compiler'
require 'crask/parser/parser'
require 'crask/cgen/code_generator_factory'
require 'crask/cgen/automatic_reference_counting_generator'
require 'crask/cgen/automatic_reference_counting_method_updater'

module CRask
  class ModuleCompilerFactory
    def create
      parser = Parser.new
      default_methods_generator = DefaultMethodsGenerator.new 
      reference_counting_generator = AutomaticReferenceCountingGenerator.new AutomaticReferenceCountingMethodUpdater.new
      code_generator = CodeGeneratorFactory.new.createCodeGenerator
      ModuleCompiler.new parser, [ default_methods_generator, reference_counting_generator ], code_generator
    end
  end
end
