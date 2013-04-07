module CRask
  class CFunctionArgumentPrinter
    def print args
      args.map{ |a| "#{a.type} #{a.name}" }.join(", ")
    end
  end
end
