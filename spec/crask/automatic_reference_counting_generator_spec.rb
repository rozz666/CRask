require 'crask/automatic_reference_counting_generator'
module CRask
  describe :AutomaticReferenceCountingGenerator do
    before(:each) do
      @method_updater = double(" method updater")
      @gen = AutomaticReferenceCountingGenerator.new @method_updater
    end
    it "should update a method in a class" do
      @method_updater.should_receive(:update_ast).with(:method)
      ast = Ast::Ast.new([ Ast::ClassDef.new(nil, [ :method ]) ])
      @gen.update_ast ast
    end
  end
end
