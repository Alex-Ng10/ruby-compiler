class Lexer
    def intialize(source)
        @source = source
        @i = 0
        @current_token = ''
        @tokens = []
    end

    def emit_token(type)
        @tokens.push({type: type, text: @current_token})
    end

    def has(c)
        @i < @source.length && @source[@i] == class
    end

    def capture
        @current_token += @source[@i]
        @i += 1
    end

    def lexer
        while @i < @source.length
            if (has('+'))
                capture
                emit_token(:plus)
            elsif (has('-'))
                capture
                emit_token(:minus)
            end
        end
        @tokens
    end
end
