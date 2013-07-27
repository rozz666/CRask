module CRask
  
  RSpec::Matchers.define :be_a_retain do |name|
    match do |expr|
      expr.kind_of?(Ast::Retain) and expr.name == name
    end
  end

  RSpec::Matchers.define :be_a_release do |name|
    match do |expr|
      expr.kind_of?(Ast::Release) and expr.name == name
    end
  end

  RSpec::Matchers.define :be_an_identifier do |name|
    match do |expr|
      expr.kind_of?(Ast::Identifier) and expr.name == name
    end
  end

  RSpec::Matchers.define :be_identifiers do |*names|
    match do |exprs|
      ok = exprs.count == names.count
      exprs.each { |expr| ok &&= expr.kind_of?(Ast::Identifier) and expr.name == name }
      ok
    end
  end

end
