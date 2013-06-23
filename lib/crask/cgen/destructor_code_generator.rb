module CRask
  class DestructorCodeGenerator
    def initialize config, name_gen
      @config = config
      @name_gen = name_gen
    end
    def generate_ast class_name
      return CAst::Function.new(
        "void", @name_gen.get_dtor_name(class_name),
        [ CAst::LocalVariable.new(@config.object_type, @config.self_var) ], [], [])
    end
  end
end
