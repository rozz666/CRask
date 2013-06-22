#--
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.2
# from lexical definition file "lib/crask/parser/racc_parser.rex".
#++

require 'racc/parser'
module CRask
class RaccParser < Racc::Parser
  require 'strscan'

  class ScanError < StandardError ; end

  attr_reader :lineno
  attr_reader :filename

  def scan_setup ; end

  def action &block
    yield
  end

  def scan_str( str )
    scan_evaluate  str
    do_parse
  end

  def load_file( filename )
    @filename = filename
    open(filename, "r") do |f|
      scan_evaluate  f.read
    end
  end

  def scan_file( filename )
    load_file  filename
    do_parse
  end

  def next_token
    @rex_tokens.shift
  end

  def scan_evaluate( str )
    scan_setup
    @rex_tokens = []
    @lineno  =  1
    ss = StringScanner.new(str)
    state = nil
    until ss.eos?
      text = ss.peek(1)
      @lineno  +=  1  if text == "\n"
      case state
      when nil
        case
        when (text = ss.scan(/\s+/))
          ;

        when (text = ss.scan(/class/))
           @rex_tokens.push action { [:class, text] }

        when (text = ss.scan(/def/))
           @rex_tokens.push action { [:def, text] }

        when (text = ss.scan(/ctor/))
           @rex_tokens.push action { [:ctor, text] }

        when (text = ss.scan(/dtor/))
           @rex_tokens.push action { [:dtor, text] }

        when (text = ss.scan(/\w+/))
           @rex_tokens.push action { [:identifier, text ] }

        when (text = ss.scan(/\{/))
           @rex_tokens.push action { [:brace_open, text ] }

        when (text = ss.scan(/\}/))
           @rex_tokens.push action { [:brace_close, text ] }

        when (text = ss.scan(/\(/))
           @rex_tokens.push action { [:paren_open, text] }

        when (text = ss.scan(/\)/))
           @rex_tokens.push action { [:paren_close, text] }

        when (text = ss.scan(/\,/))
           @rex_tokens.push action { [:comma, text] }

        when (text = ss.scan(/\./))
           @rex_tokens.push action { [:dot, text] }

        when (text = ss.scan(/=/))
           @rex_tokens.push action { [:assign, text] }

        else
          text = ss.string[ss.pos .. -1]
          raise  ScanError, "can not match: '" + text + "'"
        end  # if

      else
        raise  ScanError, "undefined state: '" + state.to_s + "'"
      end  # case state
    end  # until ss
  end  # def scan_evaluate

end # class
end # module
