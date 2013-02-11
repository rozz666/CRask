module CRask
  class VarArgDeclarator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate args
      return "" if args.empty?
      names = args.map { |a| @name_gen.get_local_name a }
      "    CRASK_OBJECT #{names.join(", ")};\n" +
      "    va_list rask_args;\n" +
      "    va_start(rask_args, classSelf);\n" +
      names.map { |n| "    #{n} = va_arg(rask_args, CRASK_OBJECT);\n" }.join +
      "    va_end(rask_args);\n"
    end
  end
end