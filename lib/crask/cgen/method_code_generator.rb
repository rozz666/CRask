module CRask
  class MethodCodeGenerator
    def initialize config, name_gen, arg_decl, stmt_gen, local_decl, local_detector
      @config = config
      @name_gen = name_gen
      @arg_decl = arg_decl
      @stmt_gen = stmt_gen
      @local_decl = local_decl
      @local_detector = local_detector
    end
    def generate_ast method, class_name
      name = @name_gen.get_method_name(class_name, method.name, method.args)
      args = @arg_decl.generate_function_args_ast(@config.self_var)
      local_vars = generate_local_vars_ast(method)
      stmts = generate_stmts_ast(method)
      CAst::Function.new(@config.object_type, name, args, local_vars, stmts)
    end
    private
    def generate_stmts_ast method
      @arg_decl.generate_initialization_ast(@config.self_var, method.args) +
      @stmt_gen.generate_ast(method.stmts) +
      [ CAst::Return.new(CAst::Variable.new(@config.nil_var)) ]
    end
    def generate_local_vars_ast method
      @local_decl.generate_ast(method.args + @local_detector.find_local_vars(method.stmts)) +
      @arg_decl.generate_local_vars_ast(method.args)
    end
  end
end
