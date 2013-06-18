module CRask
  class CLocalVariablePrinter
    def print vars
      groups = Hash.new
      vars.each do |v|
        groups[v.type] ||= [] 
        groups[v.type] << v.name
      end
      sorted_types = groups.keys.sort { |l,r| l.downcase <=> r.downcase }
      sorted_types.map { |type| "#{type} #{groups[type].join(", ")};\n" }.join 
    end
  end
end