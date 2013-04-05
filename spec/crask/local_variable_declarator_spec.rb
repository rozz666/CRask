require 'crask/local_variable_declarator'

module CRask
  describe :LocalVariableDeclarator do
    before(:each) do
      @decl = LocalVariableDeclarator.new
    end
    it "should return nothing for no variables" do
      @decl.generate_variables([]).should eql("")
    end
    it "should declare one variable" do
      @decl.generate_variables([ "var" ]).should eql("    CRASK_OBJECT var;\n")
    end
    it "should use one declaration for all variables" do
      @decl.generate_variables([ "x", "y", "A" ]).should eql("    CRASK_OBJECT x, y, A;\n")
    end
  end
end