require 'crask/local_variable_declarator'

module CRask
  describe :LocalVariableDeclarator do
    before(:each) do
      @decl = LocalVariableDeclarator.new
    end
    it "should return nothing for no variables" do
      @decl.generate_variables([]).should eql("")
    end
  end
end