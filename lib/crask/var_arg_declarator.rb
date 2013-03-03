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
    def generate_function_args self_name
      "CRASK_OBJECT #{self_name}, ..."
    end
  end
end