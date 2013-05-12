module CRask
  module Ast
    class CtorDef
      def generate_registration_code symbol_name_gen, method_name_gen, class_name, decorated_class_name
        decorated_name = symbol_name_gen.get_ctor_name class_name, name, args
        public_name = method_name_gen.generate name, args
        "crask_addClassMethodToClass(&#{decorated_name}, \"#{public_name}\", #{decorated_class_name});\n"
      end
      def generate_registration_ast symbol_name_gen, method_name_gen, class_name, class_var_name
        func_addr = CAst::VariableAddress.new(symbol_name_gen.get_ctor_name(class_name, name, args))
        public_name = CAst::String.new(method_name_gen.generate(name, args))
        class_var = CAst::Variable.new(class_var_name)
        CAst::FunctionCall.new("crask_addClassMethodToClass", [ func_addr, public_name, class_var ])
      end
    end
    class DtorDef
      def generate_registration_code symbol_name_gen, method_name_gen, class_name, decorated_class_name
        dtor_name = symbol_name_gen.get_dtor_name class_name
        "crask_addDestructorToClass(&#{dtor_name}, #{decorated_class_name});\n"
      end
      def generate_registration_ast symbol_name_gen, method_name_gen, class_name, class_var_name
        func_addr = CAst::VariableAddress.new(symbol_name_gen.get_dtor_name(class_name))
        class_var = CAst::Variable.new(class_var_name)
        CAst::FunctionCall.new("crask_addDestructorToClass", [ func_addr, class_var ])
      end
    end
    class MethodDef
      def generate_registration_code symbol_name_gen, method_name_gen, class_name, decorated_class_name
        decorated_name = symbol_name_gen.get_method_name class_name, name, args
        public_name = method_name_gen.generate name, args
        "crask_addMethodToClass(&#{decorated_name}, \"#{public_name}\", #{decorated_class_name});\n"
      end
      def generate_registration_ast symbol_name_gen, method_name_gen, class_name, class_var_name
        func_addr = CAst::VariableAddress.new(symbol_name_gen.get_method_name(class_name, name, args))
        public_name = CAst::String.new(method_name_gen.generate(name, args))
        class_var = CAst::Variable.new(class_var_name)
        CAst::FunctionCall.new("crask_addMethodToClass", [ func_addr, public_name, class_var ])
      end
    end
  end
  class ClassGenerator
    def initialize symbol_name_gen, method_name_gen, method_gen
      @symbol_name_gen = symbol_name_gen
      @method_name_gen = method_name_gen
      @method_gen = method_gen
    end
    def generate_registration class_def
      decorated_name = @symbol_name_gen.get_class_name class_def.name
      "#{decorated_name} = crask_registerClass(\"#{class_def.name}\");\n" +
      class_def.defs.map do |d|
        d.generate_registration_code @symbol_name_gen, @method_name_gen, class_def.name, decorated_name
      end.join
    end
    def generate_registration_ast class_def
      class_name = @symbol_name_gen.get_class_name class_def.name
      class_registration_call = CAst::FunctionCall.new("crask_registerClass", [ CAst::String.new(class_def.name) ])
      class_registration = CAst::Assignment.new(CAst::Variable.new(class_name), class_registration_call)
      [ class_registration ] +
      class_def.defs.map do |d|
        d.generate_registration_ast(@symbol_name_gen, @method_name_gen, class_def.name, class_name)
      end
    end
    def generate_declaration class_def
      decorated_name = @symbol_name_gen.get_class_name class_def.name
      "CRASK_CLASS #{decorated_name};\n"
    end
    def generate_declaration_ast class_def
      name = @symbol_name_gen.get_class_name class_def.name
      CAst::GlobalVariable.new("CRASK_CLASS", name)
    end
    def generate_method_definitions class_def
      class_def.defs.map do |d|
        @method_gen.generate class_def.name, d
      end.join
    end
    def generate_method_definitions_ast class_def
      class_def.defs.map do |d|
        @method_gen.generate_ast class_def.name, d
      end.flatten
    end
  end
end