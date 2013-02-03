module CRask
  class ClassGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_registration class_def
      decorated_name = @name_gen.get_class_name class_def.name
      "#{decorated_name} = crask_registerClass(\"#{class_def.name}\");\n" +
      class_def.defs.map do |d|
        dtor_name = @name_gen.get_dtor_name class_def.name
        "crask_addDestructorToClass(&#{dtor_name}, #{decorated_name});\n"
      end.join
    end
  end
end