require 'crask/cast/global_variable'
require 'crask/cast/call_facade'
require 'crask/cgen/constructor_registration_generator'
require 'crask/cgen/destructor_registration_generator'
require 'crask/cgen/method_registration_generator'
require 'crask/cgen/class_registration_generator'

module CRask
  module Ast
    class CtorDef
      def generate_registration_ast symbol_name_gen, method_name_gen, class_name, class_var_name
        ConstructorRegistrationGenerator.new(symbol_name_gen, method_name_gen).generate_ast self, class_name, class_var_name
      end
    end
    class DtorDef
      def generate_registration_ast symbol_name_gen, method_name_gen, class_name, class_var_name
        DestructorRegistrationGenerator.new(symbol_name_gen).generate_ast class_name, class_var_name
      end
    end
    class MethodDef
      def generate_registration_ast symbol_name_gen, method_name_gen, class_name, class_var_name
        MethodRegistrationGenerator.new(symbol_name_gen, method_name_gen).generate_ast self, class_name, class_var_name
      end
    end
  end
  class ClassGenerator
    def initialize symbol_name_gen, method_name_gen, method_gen, config
      @symbol_name_gen = symbol_name_gen
      @method_name_gen = method_name_gen
      @method_gen = method_gen
      @config = config
    end
    def generate_registration_ast class_def
      class_var_name = @symbol_name_gen.get_class_name class_def.name
      [ ClassRegistrationGenerator.new.generate_ast(class_def, class_var_name) ] +
      class_def.defs.map do |d|
        d.generate_registration_ast(@symbol_name_gen, @method_name_gen, class_def.name, class_var_name)
      end
    end
    def generate_declaration_ast class_def
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