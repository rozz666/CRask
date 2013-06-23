module CRask
  class ClassGenerator
    def initialize symbol_name_gen, member_gen, class_reg_gen, member_reg_gen
      @symbol_name_gen = symbol_name_gen
      @member_gen = member_gen
      @class_reg_gen = class_reg_gen
      @member_reg_gen = member_reg_gen
    end
    def generate_registration_ast class_def
      class_var_name = @symbol_name_gen.get_class_name class_def.name
      [ @class_reg_gen.generate_ast(class_def, class_var_name) ] +
      @member_reg_gen.generate_ast(class_def.defs, class_def.name, class_var_name)
    end
    def generate_method_definitions_ast class_def
      class_def.defs.map do |d|
        @member_gen.generate_ast class_def.name, d
      end.flatten
    end
  end
end