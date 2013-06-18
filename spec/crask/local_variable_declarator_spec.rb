require 'crask/local_variable_declarator'

module CRask
  describe :LocalVariableDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @decl = LocalVariableDeclarator.new @name_gen
    end
    it "should return nothing for no variables" do
      @decl.generate_ast([]).should eql([])
    end
    it "should generate AST for all variables" do
      @name_gen.should_receive(:get_local_name).with("x").and_return("X")
      @name_gen.should_receive(:get_local_name).with("y").and_return("Y")
      vars = @decl.generate_ast([ "x", "y" ])
      vars.should have(2).variables
      vars[0].should be_a_local_C_variable("CRASK_OBJECT", "X")
      vars[1].should be_a_local_C_variable("CRASK_OBJECT", "Y")
    end
  end
end