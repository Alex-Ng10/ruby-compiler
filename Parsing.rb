

class Parser
    attr_reader :i, :tokens
    def initialize(tokens)
        @tokens = tokens
        @i = 0
    end

    def parse
        level6
    end

    def advance
        @i += 1
        @tokens[@i - 1]
    end

    def has(type)
        @i < @tokens.size && @tokens[@i].type == type
    end

    def level0
        left = level1
        right = []
        while has(:comma)
            advance
            right.push(level1)
        end
        if right.size != 0
            right.insert(0, left)
            left = Block.new(right)
        end
        left
    end

    def level1
        if has(:print)
            advance
            right = level2
            left = Print.new(right)
        else
            left = level2
        end
        left 
    end

    def level 2
        if has(:var)
            left = level3
            if has(:assign)
                advance
                right = level3
                left = Assignment.new(left, right)
            end
        end
        left
    end

    def level3
        left = level4
        while true
            if has(:and)
                advance
                right = level4
                left = AndLogicalOperation.new(left, right)
            elsif has(:or)
                advance
                right = level4
                left = OrLogicalOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level4
        left = level5
        while true
            if has(:equal)
                advance 
                right = level5
                left = EqualsOperation.new(left, right)
            elsif has(:nequal)
                advance 
                right = level5
                left = NotEqualsOperation.new(left, right)
            elsif has(:greater)
                advance 
                right = level5
                left = GreaterThanOperation.new(left, right)
            elsif has(:greaterequal)
                advance 
                right = level5
                left = GreaterThanOrEqualOperation.new(left, right)
            elsif has(:less)
                advance 
                right = level5
                left = LessThanOperation.new(left, right)
            elsif has(:lessequal)
                advance 
                right = level5
                left = LessThanOrEqualOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level5
        left = level6
        while true
            if has(:band)
                advance
                right = level6
                left = BitAndOperation.new(left, right)
            elsif has(:bor)
                advance
                right = level6
                left = BitOrOperation.new(left, right)
            elsif has(:xor)
                advance
                right = level6
                left = BitXorOperation.new(left, right)
            elsif has(:left)
                advance
                right = level6
                left = LeftShiftOperation.new(left, right)
            elsif has(:right)
                advance
                right = level6
                left = RightShiftOperation.new(left, right) 
            else
                break
            end
        end
        left
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
            else
                break
            end
        end
        left
    end

    def level7
        left = level8
        while true
            if has(:multiply)
                advance
                right = level8
                left = MultiplyArithmeticOperation.new(left, right)
            elsif has(:divide)
                advance
                right = level8
                left = DivideArithmeticOperation.new(left, right)
            elsif has(:modulo)
                advance
                right = level8
                left = ModuloArithmeticOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level8
        left = level9
        while true
            if has(:exponent)
                advance
                right = level8
                left = ExponentArithmeticOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level9
        left = level10
        while true
            if has(:float_cast)
                advance
                right = level10
                left = IntToFloat.new(right)
            elsif has(:int_cast)    
                advance
                right = level10
                left = FloatToInt.new(right)
            else
                break
            end
        end
        left
    end

    def level10
        left = level11
        while true 
            if has(:not)
                advance
                right = level11
                left = NotLogicalOperation.new(right)
            elsif has(:bnot)
                advance
                right = level11
                left = BitNotOperation.new(right)
            elsif has(:negation)
                advance
                right = level11
                left = NegationArithmeticOperation.new(right)
            else
                break
            end
        end
        left
    end

    def level11
        if has(:int)
            value = IntegerPrimitive.new(advance.text.to_i)
        elsif has(:float)
            value = FloatPrimitive.new(advance.text.to_f)
        elsif has(:string)
            value = StringPrimitive.new(advance.text)
        elsif has(:true)
            value = BooleanPrimitive.new(1)
        elsif has(:false)
            value = BooleanPrimitive.new(nil)
        elsif has(:null)
            value = NullPrimitive.new
        elsif has(:leftbracket)
            advance
            value = level5
            if !has(:rightbracket)
                raise "Unclosed parathensis at #{@i}"
            end
        else
            raise "Unknown primitive #{@tokens[@i - 1].text} at #{@i}"
        end
        value
    end
end
