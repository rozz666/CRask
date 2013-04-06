module CRask
  class CGlobalVariablePrinter
    def print vars
      return "" if vars.empty?
      vars.map { |v| "#{v.type} #{v.name};\n" }.join + "\n"
    end
  end
end