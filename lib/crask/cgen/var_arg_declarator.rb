require 'crask/cast/local_variable'
require 'crask/cast/call_facade'

module CRask
  class VarArgDeclarator
    def initialize name_gen, config
      @name_gen = name_gen
      @config = config
    end
    def generate_initialization_ast self_arg, args
      return [] if args.empty?
      rask_args = CAst::Variable.new(@config.va_list)
      va_arg = CAst::Call.function("va_arg", [ rask_args, CAst::Variable.new(@config.object_type) ])
      va_start = CAst::Call.function("va_start", [ rask_args, CAst::Variable.new(self_arg) ])
      local_init = args.map { |arg|
        local_arg = CAst::Variable.new(@name_gen.get_local_name(arg))
        CAst::Assignment.new(local_arg, va_arg) 
      }
      va_end =CAst::Call.function("va_end", [ rask_args ])
      [ va_start ] + local_init + [ va_end ] 
    end
    def generate_local_vars_ast args
      return [] if args.empty?
      [ CAst::LocalVariable.new("va_list", @config.va_list)]
    end
    def generate_function_args_ast self_name
      [ CAst::LocalVariable.new(@config.object_type, self_name), CAst::LocalVariable.new("...", nil) ]
    end
  end
end