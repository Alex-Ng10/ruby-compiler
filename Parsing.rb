

class Parser
    attr_reader :i, :tokens
    def initialize(tokens)
        @tokens = tokens
        @i = 0
    end

    def parse
        level0
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
        left = level2
        if has(:function)
            advance
            name = level2
            if has(:leftbracket)
                params = []
                while true
                    advance
                    params.push(level2)
                    break if !has(:comma)
                end
                raise "Unclosed parameters at #{@i}" if !has(:rightbracket)
                advance
                block = level0
                left = FunctionDefinition.new(name, params, block)
            end
        end
        left
    end

    def level2
        left = level3
        if has(:for)
            advance
            condition = level3
            if has(:in)
                advance 
                start = level3
                if has(:to)
                    advance
                    finish = level3
                    block = level0
                    left = ForEachLoop.new(condition, start, finish, block)
                end
            end
        elsif has(:while)
            advance
            condition = level3
            block = level0
            left = WhileLoop.new(condition, block)
        elsif has(:if)
            advance
            condition = level3
            block1 = level0
            if has(:else)
                advance
                block2 = level0
                left = Conditional.new(condition, block1, block2)
            end
        end
        left
    end

    def level3
        left = level4
        i = false
        while has(:print)
            raise "More then one print at index #{tokens[@i].start}" if i
            advance
            right = level4
            left = Print.new(right)
            i = true
        end
        left 
    end

    def level4
        left = level5
        i = false
        while has(:assign)
            raise "More then one assign at index #{tokens[@i].start}" if i
            advance
            right = level5
            left = Assignment.new(left, right)
            i = true
        end
        left
    end

    def level5
        left = level6
        while true
            if has(:and)
                raise "Missing operand left of logical and at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level6
                raise "Missing operand right of logical and at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = AndLogicalOperation.new(left, right)
            elsif has(:or)
                raise "Missing operand left of logical or at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level6
                raise "Missing operand right of logical or at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = OrLogicalOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level6
        left = level7
        while true
            if has(:equal)
                raise "Missing operand left of equal at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level7
                raise "Missing operand right of equal at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = EqualsOperation.new(left, right)
            elsif has(:nequal)
                raise "Missing operand left of not equal at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level7
                raise "Missing operand right of not equal at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = NotEqualsOperation.new(left, right)
            elsif has(:greater)
                raise "Missing operand left of greater than at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level7
                raise "Missing operand right of greater than at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = GreaterThanOperation.new(left, right)
            elsif has(:greaterequal)
                raise "Missing operand left of greater or equal than at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level7
                raise "Missing operand right of greater or equal than at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = GreaterThanOrEqualOperation.new(left, right)
            elsif has(:less)
                raise "Missing operand left of less than at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level7
                raise "Missing operand right of less than at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = LessThanOperation.new(left, right)
            elsif has(:lessequal)
                raise "Missing operand left of less or equal than at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level7
                raise "Missing operand right of less or equal than at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = LessThanOrEqualOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level7
        left = level8
        while true
            if has(:band)
                raise "Missing operand left of bit and at index #{tokens[@i].start}" if  left == nil
                advance
                right = level8
                raise "Missing operand right of bit and at index #{tokens[@i - 1].start}" if  right == nil
                left = BitAndOperation.new(left, right)
            elsif has(:bor)
                raise "Missing operand left of bit or at index #{tokens[@i].start}" if  left == nil
                advance
                right = level8
                raise "Missing operand right of bit or at index #{tokens[@i - 1].start}" if  right == nil
                left = BitOrOperation.new(left, right)
            elsif has(:xor)
                raise "Missing operand left of bit xor at index #{tokens[@i].start}" if  left == nil
                advance
                right = level8
                raise "Missing operand right of bit xor at index #{tokens[@i - 1].start}" if  right == nil
                left = BitXorOperation.new(left, right)
            elsif has(:left)
                raise "Missing operand left of left shift at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level8
                raise "Missing operand right of left shift at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = LeftShiftOperation.new(left, right)
            elsif has(:right)
                raise "Missing operand left of right shift at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level8
                raise "Missing operand right of right shift at index #{tokens[@i - 1].start} to #{tokens[@i -1].back}" if  right == nil
                left = RightShiftOperation.new(left, right) 
            else
                break
            end
        end
        left
    end

    def level8
        left = level9
        while true
            if has(:plus)
                raise "Missing operand left of addition at index #{tokens[@i].start}" if  left == nil
                advance
                right = level9
                raise "Missing operand right of addition at index #{tokens[@i - 1].start}" if  right == nil
                left = AddArithmeticOperation.new(left, right)
            elsif has(:minus)
                raise "Missing operand left of subtraction at index #{tokens[@i].start}" if  left == nil
                advance
                right = level9
                raise "Missing operand right of subtraction at index #{tokens[@i - 1].start}" if  right == nil
                left = SubtractArithmeticOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level9
        left = level10
        while true
            if has(:multiply)
                raise "Missing operand left of multiplication at index #{tokens[@i].start}" if  left == nil
                advance
                right = level10
                raise "Missing operand right of multiplication at index #{tokens[@i - 1].start}" if  right == nil
                left = MultiplyArithmeticOperation.new(left, right)
            elsif has(:divide)
                raise "Missing operand left of division at index #{tokens[@i].start}" if  left == nil
                advance
                right = level10
                raise "Missing operand right of division at index #{tokens[@i - 1].start}" if  right == nil
                left = DivideArithmeticOperation.new(left, right)
            elsif has(:modulo)
                raise "Missing operand left of modulo at index #{tokens[@i].start}" if  left == nil
                advance
                right = level10
                raise "Missing operand right of modulo at index #{tokens[@i - 1].start}" if  right == nil
                left = ModuloArithmeticOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level10
        left = level11
        while true
            if has(:exponent)
                raise "Missing operand left of exponenet at index #{tokens[@i].start} to #{tokens[@i].back}" if  left == nil
                advance
                right = level10
                raise "Missing operand right of exponenet at index #{tokens[@i - 1].start} to #{tokens[@i - 1].back}" if  right == nil
                left = ExponentArithmeticOperation.new(left, right)
            else
                break
            end
        end
        left
    end

    def level11
        left = level12
        while true
            if has(:float_cast)
                advance
                right = level11
                raise "Missing operand right of float cast at index #{tokens[@i - 1].start}" if  right == nil
                left = IntToFloat.new(right)
            elsif has(:int_cast)    
                advance
                right = level11
                raise "Missing operand right of int cast at index #{tokens[@i - 1].start}" if  right == nil
                left = FloatToInt.new(right)
            else
                break
            end
        end
        left
    end

    def level12
        left = level13
        while true 
            if has(:not)
                advance
                right = level12
                raise "Missing operand right of not at index #{tokens[@i - 1].start}" if  right == nil
                left = NotLogicalOperation.new(right)
            elsif has(:bnot)
                advance
                right = level12
                raise "Missing operand right of bit not at index #{tokens[@i - 1].start}" if  right == nil
                left = BitNotOperation.new(right)
            elsif has(:negation)
                advance
                right = level12
                raise "Missing operand right of negation at index #{tokens[@i - 1].start}" if  right == nil
                left = NegationArithmeticOperation.new(right)
            else
                break
            end
        end
        left
    end

    def level13
        left = level14
        if has(:call)
            advance
            params = level0
            left = FunctionCall.new(left, params)
        end
        left
    end

    def level14
        if has(:var)
            value = Variable.new(advance.text)
        elsif has(:int)
            value = IntegerPrimitive.new(advance.text.to_i)
        elsif has(:float)
            value = FloatPrimitive.new(advance.text.to_f)
        elsif has(:string)
            value = StringPrimitive.new(advance.text)
        elsif has(:true)
            advance
            value = BooleanPrimitive.new(1)
        elsif has(:false)
            advance
            value = BooleanPrimitive.new(nil)
        elsif has(:null)
            advance
            value = NullPrimitive.new
        elsif has(:leftbracket)
            advance
            value = level5
            raise "Unclosed parathensis at #{@i}" if !has(:rightbracket)
            advance
        end
        value
    end
end
