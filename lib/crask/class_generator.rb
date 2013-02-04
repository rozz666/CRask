module CRask
  module Ast
    class CtorDef
      def generate_registration_code name_gen, class_name, decorated_class_name
        decorated_name = name_gen.get_ctor_name class_name, name
        "crask_addClassMethodToClass(&#{decorated_name}, \"#{name}\", #{decorated_class_name});\n"
      end
    end
    class DtorDef
      def generate_registration_code name_gen, class_name, decorated_class_name
        dtor_name = name_gen.get_dtor_name class_name
        "crask_addDestructorToClass(&#{dtor_name}, #{decorated_class_name});\n"
      end
    end
    class MethodDef
      def generate_registration_code name_gen, class_name, decorated_class_name
        decorated_name = name_gen.get_method_name class_name, name
        "crask_addMethodToClass(&#{decorated_name}, \"#{name}\", #{decorated_class_name});\n"
      end
    end
  end
  class ClassGenerator
    def initialize name_gen, method_gen
      @name_gen = name_gen
      @method_gen = method_gen
    end
    def generate_registration class_def
      decorated_name = @name_gen.get_class_name class_def.name
      "#{decorated_name} = crask_registerClass(\"#{class_def.name}\");\n" +
      class_def.defs.map do |d|
        d.generate_registration_code @name_gen, class_def.name, decorated_name
      end.join
    end
    def generate_declaration class_def
      decorated_name = @name_gen.get_class_name class_def.name
      "CRASK_CLASS #{decorated_name};\n"
    end
    def generate_method_definitions class_def
      class_def.defs.map do |d|
        @method_gen.generate class_def.name, d
      end.join
    end
  end
end