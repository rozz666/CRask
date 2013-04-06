module CRask
  class CIncludePrinter
    def print includes
      return "" if includes.empty?
      includes.map { |i| "#include <#{i}>\n" }.join + "\n"
    end
  end
end