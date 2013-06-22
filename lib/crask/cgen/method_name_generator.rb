module CRask
  class MethodNameGenerator
    def initialize arg_ordering_policy
      @arg_ordering_policy = arg_ordering_policy
    end
    def generate name, args
      return name if args.empty?
      args = @arg_ordering_policy.get_ordered_arguments args
      "#{name}:#{args.join(",")}"
    end
  end
end