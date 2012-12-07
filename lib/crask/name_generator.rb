module CRask
  class NameGenerator
    def get_class_name name
      "class_#{name}"
    end
    def get_method_name class_name, name
      "class_#{class_name}_method_#{name}"
    end
  end
end