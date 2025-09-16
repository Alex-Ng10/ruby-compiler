require_relative 'Tokens'

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
        @i < @source.length && 65 <= @source[@i].ord && @source[@i].ord <= 126
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
                    emit_token(:bor)
                end
            elsif has('!')
                capture
                if has('=')
                    capture
                    emit_token(:nequal)
                else
                    emit_token(:not)
                end
            elsif has('@')
                capture
                emit_token(:bnot)
            elsif has('>')
                capture
                if has('=')
                    capture
                    emit_token(:greaterequal)
                elsif has('>')
                    capture
                    emit_token(:right)
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
                    emit_token(:left)
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
                capture
                while !has('"')
                    capture
                end
                emit_token(:string)
            elsif has_character
                if has('t')
                    capture
                    if !has_character
                        emit_token(:true)
                    end
                elsif has('f')
                    capture
                    if !has_character
                        emit_token(:false)
                    end
                elsif has('n')
                    capture
                    if !has_character
                        emit_token(:null)
                    end
                else
                    while has_character
                        capture
                    end
                    emit_token(:var)
                end
            elsif has('(')
                capture
                emit_token(:bracket)
            elsif has(')')
                capture
                emit_token(:bracket)
            elsif has(' ')
                @i += 1
                current_token = ''
            else
                raise "Unknown token at #{@i}"
            end
        end
        @tokens
    end
end

l1 = Lexer.new(gets.chomp)
puts "Here are the tokens: #{l1.tokens}"