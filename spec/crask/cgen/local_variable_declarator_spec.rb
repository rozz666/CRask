require 'crask/cgen/local_variable_declarator'

module CRask
  describe :LocalVariableDeclarator do
    before(:each) do
      @name_gen = double("name generator")
      @config = double("configuration")
      @config.stub(:object_type).and_return(:OBJECT_TYPE)
      @decl = LocalVariableDeclarator.new @name_gen, @config
    end
    it "should return nothing for no variables" do
      @decl.generate_ast([]).should eql([])
    end
    it "should generate AST for all variables" do
      @name_gen.should_receive(:get_local_name).with("x").and_return("X")
      @name_gen.should_receive(:get_local_name).with("y").and_return("Y")
      vars = @decl.generate_ast([ Ast.id("x"), Ast.id("y") ])
      vars.should have(2).variables
      vars[0].should be_a_local_C_variable(:OBJECT_TYPE, "X")
      vars[1].should be_a_local_C_variable(:OBJECT_TYPE, "Y")
    end
  end
end