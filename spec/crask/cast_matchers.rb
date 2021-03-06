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
      r = actual.kind_of?(CAst::Call)
      r &&= actual.expr.kind_of?(CAst::Variable)
      r &&= actual.expr.name == name
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

  RSpec::Matchers.define :be_a_C_function do |type, name|
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
      r = actual.kind_of?(CAst::Function)
      r &&= actual.type == type
      r &&= actual.name == name
      r &&= !actual.arguments.nil?
      r &&= actual.arguments.size == @arg_count unless @arg_count.nil?
      r
    end
    description do
      d = "be a C function #{name.inspect} of type #{type.inspect}"
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
  
  RSpec::Matchers.define :be_a_C_variable_address do |name|
    match do |actual|
      actual.kind_of?(CAst::VariableAddress) and actual.name == name
    end
    description do
      "be an address of C variable #{name.inspect}"
    end
    failure_message_for_should do |actual|
      "expected #{actual.inspect} to " + description
    end
  end
end