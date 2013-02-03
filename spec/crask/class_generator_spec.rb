require 'crask/class_generator'
require 'crask/class_factory'

module CRask
  describe ClassGenerator do
    before(:each) do
      @name_gen = double("name generator")
      @gen = ClassGenerator.new @name_gen
    end
    it "should generate class registration using libcrask" do
      cdef = Ast::ClassDef.with_name "A"
      @name_gen.stub(:get_class_name).with("A").and_return("name1")
      @gen.generate_registration(cdef).should eql("name1 = crask_registerClass(\"A\");\n")
    end
  end
end