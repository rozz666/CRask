require 'crask/cast/local_variable'

module CRask
  class VarArgDeclarator
    def initialize name_gen
      @name_gen = name_gen
    end
    def generate_initialization_ast self_arg, args
      return [] if args.empty?
      rask_args = CAst::Variable.new("rask_args")
      va_arg = CAst::FunctionCall.new("va_arg", [ rask_args, CAst::Variable.new("CRASK_OBJECT") ])
      va_start = CAst::FunctionCall.new("va_start", [ rask_args, CAst::Variable.new(self_arg) ])
      local_init = args.map { |arg|
        local_arg = CAst::Variable.new(@name_gen.get_local_name(arg))
        CAst::Assignment.new(local_arg, va_arg) 
      }
      va_end =CAst::FunctionCall.new("va_end", [ rask_args ])
      [ va_start ] + local_init + [ va_end ] 
    end
    def generate_local_vars_ast args
      return [] if args.empty?
      [ CAst::LocalVariable.new("va_list", "rask_args")] #TODO: refactor rask_args
    end
    def generate_function_args_ast self_name
      [ CAst::LocalVariable.new("CRASK_OBJECT", self_name), CAst::LocalVariable.new("...", nil) ]
    end
  end
end