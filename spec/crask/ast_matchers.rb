module CRask
  
  RSpec::Matchers.define :be_a_retain do |name|
    match do |expr|
      expr.kind_of?(Ast::RetainDef) and expr.name == name
    end
  end

  RSpec::Matchers.define :be_a_release do |name|
    match do |expr|
      expr.kind_of?(Ast::ReleaseDef) and expr.name == name
    end
  end

end