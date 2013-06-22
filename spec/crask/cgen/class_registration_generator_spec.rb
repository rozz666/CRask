require 'crask/cgen/class_registration_generator'
module CRask
  describe :ClassRegistrationGenerator do
    before(:each) do
      @symbol_name_gen = double("symbol name generator")
      @config = double("configuration")
      @config.stub(:class_type).and_return(:CLASS_TYPE)

      @gen = ClassDeclarationGenerator.new @symbol_name_gen, @config
    end
    it "should generate class variable declaration C AST" do
      cdef = Ast::ClassDef.with_name "Z"
      @symbol_name_gen.should_receive(:get_class_name).with("Z").and_return("className")
      var = @gen.generate_declaration_ast(cdef)
      var.should be_a_kind_of(CAst::GlobalVariable)
      var.type.should eql(:CLASS_TYPE)
      var.name.should eql("className")
    end
  end
end
