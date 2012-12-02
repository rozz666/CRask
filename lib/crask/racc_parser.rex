class CRask::RaccParser
macro
  BLANK \s+
  BRACE_OPEN \{
  BRACE_CLOSE \}
rule
  {BLANK}
  class           { [:class, text] }
  def             { [:def, text] }
  \w+             { [:identifier, text ] }
  {BRACE_OPEN}    { [:brace_open, text ] }
  {BRACE_CLOSE}   { [:brace_close, text ] }
inner
end
