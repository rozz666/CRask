require 'crask/statement_code_generator'
require 'crask/ast/retain'
require 'crask/ast/release'

module CRask
  describe :StatementCodeGenerator do
    before(:each) do
      @assignment_gen = double("assignment generator")
      @reference_counting_generator = double("reference counting generator")
      @gen = StatementCodeGenerator.new({
        :Assignment => @assignment_gen,
        :ReferenceCounting => @reference_counting_generator
      })
    end
    it "should generate nothing when passed no statements" do
      @gen.generate_ast([]).should eql([])
    end
    it "should generate C AST for assignments" do
      stmts = [ Ast::Assignment.new("a", "nil"), Ast::Assignment.new("b", "nil") ]
      @assignment_gen.should_receive(:generate_ast).with(stmts[0]).and_return([ :a, :b ])
      @assignment_gen.should_receive(:generate_ast).with(stmts[1]).and_return([ :c, :d ])
      @gen.generate_ast(stmts).should eql([ :a, :b, :c, :d ])
    end
    it "should generate C AST for retaining variables" do
      stmts = [ Ast::Retain.new("a"), Ast::Retain.new("b") ]
      @reference_counting_generator.should_receive(:generate_retain_ast).with(stmts[0]).and_return([ :a, :b ])
      @reference_counting_generator.should_receive(:generate_retain_ast).with(stmts[1]).and_return([ :c, :d ])
      @gen.generate_ast(stmts).should eql([ :a, :b, :c, :d ])
    end
    it "should generate C AST for releasing variables" do
      stmts = [ Ast::Release.new("a"), Ast::Release.new("b") ]
      @reference_counting_generator.should_receive(:generate_release_ast).with(stmts[0]).and_return([ :a, :b ])
      @reference_counting_generator.should_receive(:generate_release_ast).with(stmts[1]).and_return([ :c, :d ])
      @gen.generate_ast(stmts).should eql([ :a, :b, :c, :d ])
    end
  end
end
