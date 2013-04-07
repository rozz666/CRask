module CRask
  module CAst
    class Assignment
      attr_reader :left, :right
      def initialize left, right
        @left = left
        @right = right
      end
    end
  end
end