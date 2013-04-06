module CRask
  class CLocalVariablePrinter
    def print vars
      groups = Hash.new
      vars.each do |v|
        groups[v.type] ||= [] 
        groups[v.type] << v.name
      end
      groups.map { |type, name| "#{type} #{name.join(", ")};\n" }.join
    end
  end
end