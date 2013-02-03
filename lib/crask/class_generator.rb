module CRask
  class ClassGenerator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_registration class_def
      decorated_name = @name_gen.get_class_name class_def.name
      "#{decorated_name} = crask_registerClass(\"#{class_def.name}\");\n"
    end
  end
end