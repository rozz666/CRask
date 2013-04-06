module CRask
  class CLocalVariablePrinter
    def print vars
      vars.map { |v| "#{v.type} #{v.name};\n" }.join
    end
  end
end