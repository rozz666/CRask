module CRask
  class ConstructorCodeGenerator
    def initialize config, name_gen, arg_decl, stmt_gen, local_decl, local_detector
      @config = config
      @name_gen = name_gen
      @arg_decl = arg_decl
      @stmt_gen = stmt_gen
      @local_decl = local_decl
      @local_detector = local_detector
    end
    def generate_ast ctor, class_name
      name = @name_gen.get_ctor_name(class_name, ctor.name, ctor.args)
      args = @arg_decl.generate_function_args_ast(@config.class_self_var)
      local_vars = generate_local_vars_ast(ctor)
      stmts = generate_stmts_ast(ctor, class_name)
      CAst::Function.new(@config.object_type, name, args, local_vars, stmts)
    end
    private
    def generate_local_vars_ast ctor
      [ CAst::LocalVariable.new(@config.object_type, @config.self_var) ] +
      @local_decl.generate_ast(ctor.args) +
      @arg_decl.generate_local_vars_ast(ctor.args)
    end   
    def generate_stmts_ast ctor, class_name
      @arg_decl.generate_initialization_ast(@config.class_self_var, ctor.args) +
      [ generate_create_instance(class_name) ] +
      [ CAst::Return.new(CAst::Variable.new(@config.self_var)) ]        
    end
    def generate_create_instance class_name
      create_instance = CAst::Call.function("crask_createInstance", [ CAst::Variable.new(@name_gen.get_class_name(class_name)) ])
      CAst::Assignment.new(CAst::Variable.new(@config.self_var), create_instance)
    end
  end
end
