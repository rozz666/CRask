require 'crask/local_variable_declarator'

module CRask
  describe :LocalVariableDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @decl = LocalVariableDeclarator.new @name_gen
    end
    it "should return nothing for no variables" do
      @decl.generate_variables([]).should eql("")
    end
    it "should declare one variable" do
      @name_gen.should_receive(:get_local_name).with("var").and_return("VAR")
      @decl.generate_variables([ "var" ]).should eql("    CRASK_OBJECT VAR;\n")
    end
    it "should use one declaration for all variables" do
      @name_gen.should_receive(:get_local_name).with("x").and_return("X")
      @name_gen.should_receive(:get_local_name).with("y").and_return("Y")
      @decl.generate_variables([ "x", "y" ]).should eql("    CRASK_OBJECT X, Y;\n")
    end
  end
end