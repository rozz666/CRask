module CRask
  class NameGenerator
    def get_class_name name
      "C_#{name}"
    end
    def get_method_name class_name, name
      "M_#{class_name}_#{name}"
    end
    def get_ctor_name class_name, name
      "class_#{class_name}_class_ctor_#{name}"
    end
    def get_dtor_name class_name
      "DT_#{class_name}"
    end
  end
end