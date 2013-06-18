require 'crask/code_generator'
require 'crask/ast_factory'

module CRask
  describe CodeGenerator do
    before(:each) do
      @class_gen = double("class generator")
      @cg = CodeGenerator.new(@class_gen)
      @ast = Ast::Ast.new
    end
    context "generate_ast" do
      it "should generate C module AST" do
        ast = Ast::Ast.with_two_classes("A", "B")
        @class_gen.should_receive(:generate_declaration_ast).with(ast.stmts[0]).and_return(:decl1)
        @class_gen.should_receive(:generate_declaration_ast).with(ast.stmts[1]).and_return(:decl2)
        @class_gen.should_receive(:generate_method_definitions_ast).with(ast.stmts[0]).and_return([ :func1, :func2 ])
        @class_gen.should_receive(:generate_method_definitions_ast).with(ast.stmts[1]).and_return([ :func3, :func4 ])
        @class_gen.should_receive(:generate_registration_ast).with(ast.stmts[0]).and_return([ :reg1, :reg2 ])
        @class_gen.should_receive(:generate_registration_ast).with(ast.stmts[1]).and_return([ :reg3, :reg4 ])
          
        c_module = @cg.generate_ast ast
        c_module.should be_a_kind_of(CAst::Module)
        c_module.includes.should eql([ "crask.h", "stdarg.h" ])
        c_module.global_variables.should eql([ :decl1, :decl2 ])
        c_module.should have(5).functions
        c_module.functions[0..3].should eql([ :func1, :func2, :func3, :func4 ])
        c_main = c_module.functions[4]
        c_main.should be_a_kind_of(CAst::Function)
        c_main.type.should eql("int")
        c_main.name.should eql("main")
        c_main.should have(0).arguments
        c_main.should have(0).local_variables
        c_main.statements.should eql([ :reg1, :reg2, :reg3, :reg4 ])
      end
    end
  end
end