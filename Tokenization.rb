class Lexer
    attr_reader :source, :i, :current_token, :tokens
    def initialize(source)
        @source = source
        @i = 0
        @current_token = ''
        @tokens = []
        lexer
    end

    def emit_token(type)
        @tokens.push(Token.new(type, @current_token, @i - @current_token.length, @i - 1))
        @current_token = ''   # reset captured chars for next token
    end

    def has(c)
        @i < @source.length && @source[@i] == c
    end

    def has_digit
        @i < @source.length && '0' <= @source[@i] && @source[@i] <= '9'
    end

    def has_character
            # check ASCII letters only (A-Z / a-z) and identifiers limited to letters
        return @i < @source.length && (('a' <= @source[@i] && @source[@i] <= 'z') || ('A' <= @source[@i] && @source[@i] <= 'Z'))
    end

    def capture
        @current_token += @source[@i]
        @i += 1
    end

    def lexer
        while @i < @source.length
            if has(',')
                capture
                emit_token(:comma)
            elsif has('$')
                capture
                emit_token(:print)
            elsif has('=')
                capture
                if has('=')
                    capture
                    emit_token(:equal)
                else
                    emit_token(:assign)
                end
            elsif has('&')
                capture
                if has('&')
                    capture
                    emit_token(:and)
                else
                    emit_token(:band)
                end
            elsif has('|')
                capture
                if has('|')
                    capture
                    emit_token(:or)
                else
                    emit_token(:bor)     # '|' bitwise OR
                end
            elsif has('!')
                capture
                if has('=')
                    capture
                    emit_token(:nequal)
                else
                    emit_token(:not)     # '!' logical NOT
                end
            elsif has('@')
                capture
                emit_token(:bnot)       # '@' used as bitwise NOT 
            elsif has('>')
                capture
                if has('=')
                    capture
                    emit_token(:greaterequal)
                elsif has('>')
                    capture
                    emit_token(:right)   # '>>' right shift
                else
                    emit_token(:greater)
                end
            elsif has('<')
                capture
                if has('=')
                    capture
                    emit_token(:lessequal)
                elsif has('<')
                    capture
                    emit_token(:left)    # '<<' left shift
                else
                    emit_token(:less)
                end
            elsif has('^')
                capture
                emit_token(:xor)
            elsif has('~')
                capture
                emit_token(:negation)
            elsif has('+')
                capture
                emit_token(:plus)
            elsif has('-')
                capture
                emit_token(:minus)
            elsif has('*')
                capture
                if has('*')
                    capture
                    emit_token(:exponent)
                else
                    emit_token(:multiply)
                end
            elsif has('/')
                capture
                emit_token(:divide)
            elsif has('%')
                capture
                emit_token(:modulo)
            elsif has('[')
                capture
                emit_token(:float_cast)
            elsif has(']')
                capture
                emit_token(:int_cast)
            elsif has('.')
                capture
                emit_token(:period)
            elsif has_digit
                # integer or float: capture whole number, then optionally '.' and fractional part
                while has_digit
                    capture
                end
                if has('.')
                    capture
                    while has_digit
                        capture
                    end
                    emit_token(:float)
                else
                    emit_token(:int)
                end
            elsif has('"')
                @i += 1
                # capture until closing quote; current_token accumulates content without quotes
                while (!has('"') && @i != source.length)
                    capture
                end
                # checking if quote missing
                raise "Incomplete string token \"#{@current_token} from #{@i - @current_token.length - 1} to #{@i - 1}" if !has('"')
                @i += 1
                emit_token(:string)
            elsif has_character
                # capture all letters
                while has_character
                    capture
                end
                # special-case single-letter keywords: t, f, n -> true/false/null
                if @current_token == "t"
                    emit_token(:true)
                elsif @current_token == "f"
                    emit_token(:false)
                elsif @current_token == "n"
                    emit_token(:null)
                elsif @current_token == "func"
                    emit_token(:function)
                elsif @current_token == "for"
                    emit_token(:for)
                elsif @current_token == "in"
                    emit_token(:in)
                elsif @current_token == "to"
                    emit_token(:to)
                elsif @current_token == "while"
                    emit_token(:while)
                elsif @current_token == "then"
                    emit_token(:then)
                elsif @current_token == "if"
                    emit_token(:if)
                elsif @current_token == "else"
                    emit_token(:else)
                elsif @current_token == "call"
                    emit_token(:call)
                else
                    emit_token(:var)
                end
            elsif has('(')
                capture
                emit_token(:leftbracket)
            elsif has(')')
                capture
                emit_token(:rightbracket)
            elsif has(' ')
                @i += 1
                @current_token = ''
            else
                capture
                raise "Unknown token #{@current_token} at index #{@i - 1}"
            end
        end
        @tokens
    end
end
