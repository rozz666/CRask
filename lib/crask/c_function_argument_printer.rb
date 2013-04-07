module CRask
  class CFunctionArgumentPrinter
    def print args
      args.map{ |a| print_arg a }.join(", ")
    end
    private
    def print_arg a
      return a.type if a.type == "..."
      "#{a.type} #{a.name}"
    end
  end
end
