require 'crask/cast/global_variable'
require 'crask/cast/call_facade'
require 'crask/cgen/constructor_registration_generator'
require 'crask/cgen/destructor_registration_generator'
require 'crask/cgen/method_registration_generator'
require 'crask/cgen/class_registration_generator'
require 'crask/cgen/member_registration_generator'

module CRask
  class ClassGenerator
    def initialize symbol_name_gen, method_name_gen, method_gen, config
      @symbol_name_gen = symbol_name_gen
      @method_gen = method_gen
      @config = config
      @generators = {
        :Constructor => ConstructorRegistrationGenerator.new(symbol_name_gen, method_name_gen),
        :Destructor => DestructorRegistrationGenerator.new(symbol_name_gen),
        :Method => MethodRegistrationGenerator.new(symbol_name_gen, method_name_gen)
      }
      @class_reg_gen = ClassRegistrationGenerator.new
      @member_reg_gen = MemberRegistrationGenerator.new @generators
    end
    def generate_registration_ast class_def
      class_var_name = @symbol_name_gen.get_class_name class_def.name
      [ @class_reg_gen.generate_ast(class_def, class_var_name) ] +
      @member_reg_gen.generate_ast(class_def.defs, class_def.name, class_var_name)
    end
    def generate_declaration_ast class_def #TODO extract into ClassDeclarationGenerator
      name = @symbol_name_gen.get_class_name class_def.name
      CAst::GlobalVariable.new(@config.class_type, name)
    end
    def generate_method_definitions_ast class_def
      class_def.defs.map do |d|
        @method_gen.generate_ast class_def.name, d
      end.flatten
    end
  end
end