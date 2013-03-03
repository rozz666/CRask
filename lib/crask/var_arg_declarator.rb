module CRask
  class VarArgDeclarator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_from_self_arg self_arg, args
      return "" if args.empty?
      names = args.map { |a| @name_gen.get_local_name a }
      "    CRASK_OBJECT #{names.join(", ")};\n" +
      "    va_list rask_args;\n" +
      "    va_start(rask_args, #{self_arg});\n" +
      names.map { |n| "    #{n} = va_arg(rask_args, CRASK_OBJECT);\n" }.join +
      "    va_end(rask_args);\n"
    end
    def generate_method_args args
      return "" if args.empty?
      self_arg = @name_gen.get_self_name
      names = args.map { |a| @name_gen.get_local_name a }
      "    CRASK_OBJECT #{names.join(", ")};\n" +
      "    va_list rask_args;\n" +
      "    va_start(rask_args, #{self_arg});\n" +
      names.map { |n| "    #{n} = va_arg(rask_args, CRASK_OBJECT);\n" }.join +
      "    va_end(rask_args);\n"
    end
    def generate_function_args self_name
      generate_function_args_with_self_name self_name
    end
    def generate_class_function_args
      generate_function_args_with_self_name @name_gen.get_class_self_name
    end
    private
    def generate_function_args_with_self_name self_name
      "CRASK_OBJECT #{self_name}, ..."
    end
  end
end