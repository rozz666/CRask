module CRask
  class NameGenerator
    def get_class_name name
      "C_#{name}"
    end
    def get_method_name class_name, name
      "M_#{class_name}_#{name}"
    end
    def get_ctor_name class_name, name
      "CT_#{class_name}_#{name}"
    end
    def get_ctor_name_with_args class_name, name, args
      "CT_#{class_name}_#{name}" + args.map { |a| "_#{a}" }.join
    end
    def get_dtor_name class_name
      "DT_#{class_name}"
    end
    def get_local_name var_name
      "L_#{var_name}"
    end
  end
end