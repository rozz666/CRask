class CRask::RaccParser
macro
  BLANK \s+
  BRACE_OPEN \{
  BRACE_CLOSE \}
  PAREN_OPEN \(
  PAREN_CLOSE \)
  COMMA \,
  ASSIGN =
rule
  {BLANK}
  class           { [:class, text] }
  def             { [:def, text] }
  ctor            { [:ctor, text] }
  dtor            { [:dtor, text] }
  \w+             { [:identifier, text ] }
  {BRACE_OPEN}    { [:brace_open, text ] }
  {BRACE_CLOSE}   { [:brace_close, text ] }
  {PAREN_OPEN}    { [:paren_open, text] }
  {PAREN_CLOSE}   { [:paren_close, text] }
  {COMMA}         { [:comma, text] }
  {ASSIGN}        { [:assign, text] }
inner
end
