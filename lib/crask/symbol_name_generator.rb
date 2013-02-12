module CRask
  class SymbolNameGenerator
    def initialize arg_ordering_policy
      @arg_ordering_policy = arg_ordering_policy
    end
    def get_class_name name
      "C_#{name}"
    end
    def get_method_name class_name, name, args
      args = @arg_ordering_policy.get_ordered_arguments args unless args.empty?
      "M_#{class_name}_#{name}" + args.map { |a| "_#{a}" }.join
    end
    def get_ctor_name class_name, name, args
      args = @arg_ordering_policy.get_ordered_arguments args unless args.empty?
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