require_relative 'Translation'
require_relative 'Evaluation'

class One
    attr_reader :value
    def initialize(value)
        @value = value
    end
end

class Two
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
end

class IntegerPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_integer(self)
    end
end

class FloatPrimitive < One
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_float(self)
    end
end

class BooleanPrimitive < One
    def initialize(value)
        if (value)
            @value = true
        else
            @value = false
        end
    end

    def visit(visitor)
        visitor.visit_boolean(self)
    end
end

class StringPrimitive < One
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_string(self)
    end
end

class NullPrimitive < One
    def initialize()
        @value = nil
    end

    def visit(visitor)
        visitor.visit_null(self)
    end
end

class AddArithmeticOperation < Two
    def visit(visitor)
        visitor.visit_arithm_add(self)
    end
end

class SubtractArithmeticOperation < Two
    def visit(visitor)
        visitor.visit_arithm_sub(self)
    end
end

class MultiplyArithmeticOperation < Two
    def visit(visitor)
        visitor.visit_arithm_mul(self)
    end
end

class DivideArithmeticOperation < Two
    def visit(visitor)
        visitor.visit_arithm_div(self)
    end
end

class ModuloArithmeticOperation < Two
    def visit(visitor)
        visitor.visit_arithm_mod(self)
    end
end

class ExponentArithmeticOperation < Two
    def visit(visitor)
        visitor.visit_arithm_exp(self)
    end
end

class NegationArithmeticOperation < One
    def visit(visitor)
        visitor.visit_arithm_neg(self)
    end
end

# Logical Operations

class AndLogicalOperation < Two
    def visit(visitor)
        visitor.visit_log_and(self)
    end
end

class OrLogicalOperation < Two
    def visit(visitor)
        visitor.visit_log_or(self)
    end
end

class NotLogicalOperation < One
    def visit(visitor)
        visitor.visit_log_not(self)
    end
end

# Bitwise Operations

class BitAndOperation < Two
    def visit(visitor)
        visitor.visit_bit_and(self)
    end
end

class BitOrOperation < Two
    def visit(visitor)
        visitor.visit_bit_or(self)
    end
end

class BitXorOperation < Two
    def visit(visitor)
        visitor.visit_bit_xor(self)
    end
end

class BitNotOperation < One
    def visit(visitor)
        visitor.visit_bit_not(self)
    end
end

class LeftShiftOperation < Two
    def visit(visitor)
        visitor.visit_left_shift(self)
    end
end

class RightShiftOperation < Two
    def visit(visitor)
        visitor.visit_right_shift(self)
    end
end

# Relational Operations

class EqualsOperation < Two
    def visit(visitor)
        visitor.visit_equals(self)
    end
end

class NotEqualsOperation < Two
    def visit(visitor)
        visitor.visit_not_equals(self)
    end
end

class LessThanOperation < Two
    def visit(visitor)
        visitor.visit_less_than(self)
    end
end

class LessThanOrEqualOperation < Two
    def visit(visitor)
        visitor.visit_less_than_or_equal(self)
    end
end

class GreaterThanOperation < Two
    def visit(visitor)
        visitor.visit_greater_than(self)
    end
end

class GreaterThanOrEqualOperation < Two
    def visit(visitor)
        visitor.visit_greater_than_or_equal(self)
    end
end

# Casting Operations

class FloatToInt < One
    def visit(visitor)
        visitor.visit_float_int(self)
    end
end

class IntToFloat < One
    def visit(visitor)
        visitor.visit_int_float(self)
    end
end

# Other

class Variable < One
    def visit(visitor)
        visitor.visit_var(self)
    end
end

class Assignment < Two
    def visit(visitor)
        visitor.visit_assign(self)
    end
end

class Print < One
    def visit(visitor)
        visitor.visit_print(self)
    end
end

class Block
    attr_reader :array
    def initialize(array)
        @array = array
    end

    def visit(visitor)
        visitor.visit_block(self)
    end
end

# Primitive Operations

p1 = IntegerPrimitive.new(8)
puts p1.visit(Translator.new)
puts p1.visit(Evaluator.new(Runtime.new)).value
p2 = FloatPrimitive.new(2.0)
puts p2.visit(Translator.new)
puts p2.visit(Evaluator.new(Runtime.new)).value
p3 = BooleanPrimitive.new(nil)
puts p3.visit(Translator.new)
puts p3.visit(Evaluator.new(Runtime.new)).value
p4 = StringPrimitive.new("hello there")
puts p4.visit(Translator.new)
puts p4.visit(Evaluator.new(Runtime.new)).value
p5 = NullPrimitive.new
puts p5.visit(Translator.new)
puts p5.visit(Evaluator.new(Runtime.new)).value

# Arithmetic Operations

a1 = AddArithmeticOperation.new(p1, p2)
puts a1.visit(Translator.new)
puts a1.visit(Evaluator.new(Runtime.new)).value
a2 = SubtractArithmeticOperation.new(p1, p2)
puts a2.visit(Translator.new)
puts a2.visit(Evaluator.new(Runtime.new)).value
a3 = MultiplyArithmeticOperation.new(p1, p2)
puts a3.visit(Translator.new)
puts a3.visit(Evaluator.new(Runtime.new)).value
a4 = DivideArithmeticOperation.new(p1, p2)
puts a4.visit(Translator.new)
puts a4.visit(Evaluator.new(Runtime.new)).value
a5 = ModuloArithmeticOperation.new(p1, p2)
puts a5.visit(Translator.new)
puts a5.visit(Evaluator.new(Runtime.new)).value
a6 = ExponentArithmeticOperation.new(p1, p2)
puts a6.visit(Translator.new)
puts a6.visit(Evaluator.new(Runtime.new)).value
a7 = NegationArithmeticOperation.new(p1)
puts a7.visit(Translator.new)
puts a7.visit(Evaluator.new(Runtime.new)).value

# Logical operations

l1 = AndLogicalOperation.new(p3, p3)  
puts l1.visit(Translator.new)
puts l1.visit(Evaluator.new(Runtime.new)).value
l2 = OrLogicalOperation.new(p3, p3)
puts l2.visit(Translator.new)
puts l2.visit(Evaluator.new(Runtime.new)).value
l3 = NotLogicalOperation.new(p3)
puts l3.visit(Translator.new)  
puts l3.visit(Evaluator.new(Runtime.new)).value

# Bitwise Operations

i1 = IntegerPrimitive.new(9)
i2 = IntegerPrimitive.new(3)

b1 = BitAndOperation.new(i1, i2)
puts b1.visit(Translator.new)
puts b1.visit(Evaluator.new(Runtime.new)).value
b2 = BitOrOperation.new(i1, i2)
puts b2.visit(Translator.new)
puts b2.visit(Evaluator.new(Runtime.new)).value
b3 = BitXorOperation.new(i1, i2)
puts b3.visit(Translator.new)
puts b3.visit(Evaluator.new(Runtime.new)).value
b4 = BitNotOperation.new(i1)
puts b4.visit(Translator.new)
puts b4.visit(Evaluator.new(Runtime.new)).value
b5 = LeftShiftOperation.new(i1, i2)
puts b5.visit(Translator.new)
puts b5.visit(Evaluator.new(Runtime.new)).value
b6 = RightShiftOperation.new(i1, i2)
puts b6.visit(Translator.new)
puts b6.visit(Evaluator.new(Runtime.new)).value

# Relational Operations

x1 = IntegerPrimitive.new(10)
x2 = IntegerPrimitive.new(10)

r1 = EqualsOperation.new(x1, x2)
puts r1.visit(Translator.new)
puts r1.visit(Evaluator.new(Runtime.new)).value
r2 = NotEqualsOperation.new(x1, x2)
puts r2.visit(Translator.new)
puts r2.visit(Evaluator.new(Runtime.new)).value
r3 = LessThanOperation.new(x1, x2)
puts r3.visit(Translator.new)
puts r3.visit(Evaluator.new(Runtime.new)).value
r4 = LessThanOrEqualOperation.new(x1, x2)
puts r4.visit(Translator.new)
puts r4.visit(Evaluator.new(Runtime.new)).value
r5 = GreaterThanOperation.new(x1, x2)
puts r5.visit(Translator.new)
puts r5.visit(Evaluator.new(Runtime.new)).value
r6 = GreaterThanOrEqualOperation.new(x1, x2)
puts r6.visit(Translator.new)
puts r6.visit(Evaluator.new(Runtime.new)).value

# Casting Operations

c1 = IntegerPrimitive.new(9)
c2 = FloatPrimitive.new(4.5)

c3 = FloatToInt.new(c2)
puts c3.visit(Translator.new)
puts c3.visit(Evaluator.new(Runtime.new)).value
c4 = IntToFloat.new(c1)
puts c4.visit(Translator.new)
puts c4.visit(Evaluator.new(Runtime.new)).value

# Other

o1 = StringPrimitive.new("hi")

o2 = Variable.new(o1)
puts o2.visit(Translator.new)
puts o2.visit(Evaluator.new(Runtime.new))
o3 = Assignment.new(o2, a1)
puts o3.visit(Translator.new)
puts o3.visit(Evaluator.new(Runtime.new))
o4 = Print.new(a1)
puts o4.visit(Translator.new)
puts o4.visit(Evaluator.new(Runtime.new))
o5 = Block.new([o2, o3, o2])
puts o5.visit(Translator.new)
puts o5.visit(Evaluator.new(Runtime.new))
o6 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("x")), IntegerPrimitive.new(9)), Assignment.new(Variable.new(StringPrimitive.new("y")), MultiplyArithmeticOperation.new(Variable.new(StringPrimitive.new("x")), IntegerPrimitive.new(9))), Assignment.new(Variable.new(StringPrimitive.new("y")), MultiplyArithmeticOperation.new(Variable.new(StringPrimitive.new("y")), IntegerPrimitive.new(9)))])
puts o6.visit(Translator.new)
puts o6.visit(Evaluator.new(Runtime.new))

r1 = AddArithmeticOperation.new(AddArithmeticOperation.new(IntegerPrimitive.new(5),FloatPrimitive.new(10.5)),SubtractArithmeticOperation.new(BitOrOperation.new(IntegerPrimitive.new(6),IntegerPrimitive.new(12)),BitAndOperation.new(IntegerPrimitive.new(5),IntegerPrimitive.new(3))))
puts r1.visit(Translator.new)
puts r1.visit(Evaluator.new(Runtime.new)).value

# Demonstration

# # Arithmetic: (7 * 4 + 3) % 12
# d1 = ModuloArithmeticOperation.new(AddArithmeticOperation.new(MultiplyArithmeticOperation.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4)), IntegerPrimitive.new(3)), IntegerPrimitive.new(12))
# puts d1.visit(Translator.new)
# puts d1.visit(Evaluator.new(Runtime.new)).value

# # Arithmetic negation and rvalues: a * b
# d2 = MultiplyArithmeticOperation.new(Variable.new(StringPrimitive.new("a")), Variable.new(StringPrimitive.new("b")))
# # puts d2.visit(Translator.new)
# # puts d2.visit(Evaluator.new(Runtime.new)).value

# # Rvalue lookup and shift: i << 3
# d3 = RightShiftOperation.new(Variable.new(StringPrimitive.new("i")), IntegerPrimitive.new(3))

# # Rvalue lookup and comparison: j == j + 0
# d4 = EqualsOperation.new(Variable.new(StringPrimitive.new("j")), AddArithmeticOperation.new(Variable.new(StringPrimitive.new("j")), IntegerPrimitive.new(0)))

# # Logic and comparison: !(3.3 > 3.2)
# d5 = NotLogicalOperation.new(GreaterThanOperation.new(FloatPrimitive.new(3.3), FloatPrimitive.new(3.2)))
# puts d5.visit(Translator.new)
# puts d5.visit(Evaluator.new(Runtime.new)).value

# # Double negation: --(6 * 8)
# d6 = NegationArithmeticOperation.new(NegationArithmeticOperation.new(MultiplyArithmeticOperation.new(IntegerPrimitive.new(6), IntegerPrimitive.new(8))))
# puts d6.visit(Translator.new)
# puts d6.visit(Evaluator.new(Runtime.new)).value

# # Bitwise operations: ~5 | ~8
# d7 = BitOrOperation.new(BitNotOperation.new(IntegerPrimitive.new(5)), BitNotOperation.new(IntegerPrimitive.new(8)))
# puts d7.visit(Translator.new)
# puts d7.visit(Evaluator.new(Runtime.new)).value

# # Casting: float(7) / 2
# d8 = DivideArithmeticOperation.new(IntToFloat.new(IntegerPrimitive.new(7)), IntegerPrimitive.new(2))
# puts d8.visit(Translator.new)
# puts d8.visit(Evaluator.new(Runtime.new)).value

# # Assignment: n = 9 & 3
# d9 = Assignment.new(Variable.new(StringPrimitive.new("n")), BitAndOperation.new(IntegerPrimitive.new(9), IntegerPrimitive.new(3)))
# puts d9.visit(Translator.new)
# puts d9.visit(Evaluator.new(Runtime.new))