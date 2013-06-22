module CRask
  class ClassDeclarationGenerator
    def initialize symbol_name_gen, config
      @symbol_name_gen = symbol_name_gen
      @config = config
    end
    def generate_declaration_ast class_def
      name = @symbol_name_gen.get_class_name class_def.name
      CAst::GlobalVariable.new(@config.class_type, name)
    end
  end
end
