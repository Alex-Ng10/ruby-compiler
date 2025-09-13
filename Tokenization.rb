require_relative 'Tokens'

class Lexer
    attr_reader :source, :i, :current_token, :tokens
    def intialize(source)
        @source = source
        @i = 0
        @current_token = ''
        @tokens = []
    end

    def emit_token(type)
        @tokens.push(Token.new(type, @current_token, @i, @i + @current_token.length - 1))
        @current_token = ''
    end

    def has(c)
        @i < @source.length && @source[@i] == c
    end

    def has_digit
        @i < @source.length && '0' <= @source[@i] && @source[@i] <= '9'
    end

    def has_character
        @i < @source.length && 65 <= @source[@i].ord && @source[@i] <= 126
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
                emit_token(:equal)
            elsif has('&')
                capture
                emit_token(:and)
            elsif has('|')
                capture
                emit_token(:or)
            elsif has('!')
                capture
                emit_token(:not)
            elsif has('>')
                capture
                emit_token(:greater)
            elsif has('<')
                capture
                emit_token(:less)
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
                emit_token(:multiply)
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
                while has_digit
                    capture
                end
                emit_token(:int)
            elsif has_character
                while has_character
                    capture
                end
                emit_token(:string)
            elsif has('(')
                capture
                emit_token(:open_bracket)
            elsif has(')')
                capture
                emit_token(:close_bracket)
            elsif has(' ')
                @i += 1
                current_token = ''
            else
                raise "Unknown token #{@current_token}"
            end
        end
        @tokens
    end
end

l1 = Lexer.new("hi")
puts l1.tokens