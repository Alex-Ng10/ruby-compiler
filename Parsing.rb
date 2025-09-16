class Parser
    def intialize(tokens)
        @tokens = tokens
        @i = 0
    end

    def Parser
        level0
    end

    def advance
        @i += 1
        @tokens[@i - 1]
    end

    def has(type)
        @i < @tokens.size && @tokens[@i][:type] == type
    end

    def level0
        left = level1
        right = []
        while has(:comma)
            advance
            right.push(level1)
        end
        if block.size == 0
            left = Block.new(right)
        end
        left
    end

    def level1
        left = level2
        if has(:print)
            advance
            right = level2
            left = Print.new(right)
        end
        left 
    end

    def level2

    def level6
        left = level7
        while has(:plus)
    end

    def level6
        left = level7
        while true
            if has(:plus)
                advance
                right = level7
                left = AddArithmeticOperation.new(left, right)
            elsif has(:minus)
                advance
                right = level7
                left = SubtractArithmeticOperation.new(left, right)
            elsif has(:multiply)
                advance
                right = level7
                left = MultiplyArithmeticOperation.new(left, right)
            elsif has(:divide)
                advance
                right = level7
                left = DivideArithmeticOperation.new(left, right)
            elsif has(:modulo)
                advance
                right = level7
                left = ModuloArithmeticOperation.new(left, right)
            elsif has(:exponent)
                advance
                right = level7
                left = ExponentArithmeticOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level11
        if has(:int)
            return IntegerPrimitive.new(advance[:text].to_i)
        elsif has(:float)
            return FloatPrimitive.new(advance[:text].to_f)
        elsif has(:string)
            return StringPrimitive.new(advance[:text].to_s)
        elsif has(:true)
            return BooleanPrimitive.new(1)
        elsif has(:false)
            return BooleanPrimitive.new(nil)
        elsif has(:null)
            return NullPrimitive.new
        elsif has(:bracket)
            return level3
        else
            raise "Unknown primitive at "
        end
    end
end