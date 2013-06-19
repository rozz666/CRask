require 'crask/automatic_reference_counting_generator'
module CRask
  describe :AutomaticReferenceCountingGenerator do
    before(:each) do
      @method_updater = double(" method updater")
      @gen = AutomaticReferenceCountingGenerator.new @method_updater
    end
    it "should update all methods in a class" do
      @method_updater.should_receive(:update_ast).with(:method1)
      @method_updater.should_receive(:update_ast).with(:method2)
      ast = Ast::Ast.new([ Ast::ClassDef.new(nil, [ :method1, :method2 ]) ])
      @gen.update_ast ast
    end
  end
end
