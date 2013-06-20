require 'crask/local_variable_detector'
module CRask
  describe :LocalVariableDetector do
    before(:each) do
      @detector = LocalVariableDetector.new
    end
    it "should return nothing for no statements" do
      @detector.find_local_variables([]).should eql([])
    end
  end
end
