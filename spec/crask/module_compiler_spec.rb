require 'crask/module_compiler'

module CRask
  describe :ModuleCompiler do
    before(:each) do
      @parser = double('parser')
      @updater1 = double('updater 1')
      @updater2 = double('updater 2')
      @code_gen = double('code generator')
      @compiler = ModuleCompiler.new(@parser, [ @updater1, @updater2 ], @code_gen)
    end
    it "should parse source, update generated ast and generate code" do
      @parser.should_receive(:parse).with(:source).and_return(:ast)
      @updater1.should_receive(:update_ast).with(:ast) {
        @updater2.should_receive(:update_ast).with(:ast) {
          @code_gen.should_receive(:generate_ast).with(:ast).and_return(:code)
        }
      }
      
      @compiler.compile(:source).should be(:code)
    end
  end
end