module CRask
  
  RSpec::Matchers.define :be_a_C_variable do |name|
    match do |expr|
      expr.kind_of?(CAst::Variable) and expr.name == name
    end
  end
  
  RSpec::Matchers.define :be_a_C_function_call do |name|
    chain :with do |n|
      @arg_count = n
    end
    chain :args do
      @args = "arguments"
    end
    chain :arg do
      @args = "argument"
    end
    match do |actual|
      r = actual.kind_of?(CAst::FunctionCall)
      r &&= actual.name == name
      r &&= !actual.args.nil?
      r &&= actual.args.size == @arg_count unless @arg_count.nil?
      r
    end
    description do
      d = "be a call of C function #{name.inspect}"
      d += " with #{@arg_count} #{@args}" unless @arg_count.nil?
      d
    end
    failure_message_for_should do |actual|
      "expected #{actual.inspect} to " + description
    end
  end
  
  RSpec::Matchers.define :be_a_local_C_variable do |type, name|
    match do |actual|
      actual.kind_of?(CAst::LocalVariable) and actual.type == type and actual.name == name
    end
    description do
      "be a local C variable #{name.inspect} of type #{type.inspect}"
    end
    failure_message_for_should do |actual|
      "expected #{actual.inspect} to " + description
    end
  end

  RSpec::Matchers.define :be_a_C_string do |value|
    match do |actual|
      actual.kind_of?(CAst::String) and actual.value == value
    end
    description do
      "be a C string #{value.inspect}"
    end
    failure_message_for_should do |actual|
      "expected #{actual.inspect} to " + description
    end
  end
end