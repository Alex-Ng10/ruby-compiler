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

class IntegerPrimitive < One
    def initialize(value)
        @value = Integer(value)
    end

    def visit(visitor)
        visitor.visit_integer(self)
    end
end

class FloatPrimitive < One
    def initialize(value)
        @value = Float(value)
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
        @value = String(value)
    end

    def visit(visitor)
        visitor.visit_float(self)
    end
end

class NullPrimitive < One
    def initialize()
        @value = nil
    end

    def visit(visitor)
        visitor.visit_float(self)
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

class Block < One
    def visit(visitor)
        visitor.visit_print(self)
    end
end

# Primitive Operations

p1 = IntegerPrimitive.new(8)
puts p1.visit(Translator.new)
puts p1.visit(Evaluator.new)
p2 = FloatPrimitive.new(2.0)
puts p2.visit(Translator.new)
puts p2.visit(Evaluator.new)
p3 = BooleanPrimitive.new(nil)
puts p3.visit(Translator.new)
puts p3.visit(Evaluator.new)
p4 = StringPrimitive.new("hello there")
puts p4.visit(Translator.new)
puts p4.visit(Evaluator.new)
p5 = NullPrimitive.new
puts p5.visit(Translator.new)
puts p5.visit(Evaluator.new)

# Arithmetic Operations

a1 = AddArithmeticOperation.new(p1, p2)
puts a1.visit(Translator.new)
puts a1.visit(Evaluator.new)
a2 = SubtractArithmeticOperation.new(p1, p2)
puts a2.visit(Translator.new)
puts a2.visit(Evaluator.new)
a3 = MultiplyArithmeticOperation.new(p1, p2)
puts a3.visit(Translator.new)
puts a3.visit(Evaluator.new)
a4 = DivideArithmeticOperation.new(p1, p2)
puts a4.visit(Translator.new)
puts a4.visit(Evaluator.new)
a5 = ModuloArithmeticOperation.new(p1, p2)
puts a5.visit(Translator.new)
puts a5.visit(Evaluator.new)
a6 = ExponentArithmeticOperation.new(p1, p2)
puts a6.visit(Translator.new)
puts a6.visit(Evaluator.new)
a7 = NegationArithmeticOperation.new(p1)
puts a7.visit(Translator.new)
puts a7.visit(Evaluator.new)

# Logical operations

l1 = AndLogicalOperation.new(p3, p3)  # Those are the 3 logical operations that had to be implemented similarly to the exponentiation since they both use 2 boolean values.
puts l1.visit(Translator.new)
puts l1.visit(Evaluator.new)
l2 = OrLogicalOperation.new(p3, p3)
puts l2.visit(Translator.new)
puts l2.visit(Evaluator.new)
l3 = NotLogicalOperation.new(p3)     # This works similarly to the negation operation, since we just take a value and apply a negation operation.
puts l3.visit(Translator.new)
puts l3.visit(Evaluator.new)

# Bitwise Operations

i1 = IntegerPrimitive.new(9)
i2 = IntegerPrimitive.new(3)

b1 = BitAndOperation.new(i1, i2)
puts b1.visit(Translator.new)
puts b1.visit(Evaluator.new)
b2 = BitOrOperation.new(i1, i2)
puts b2.visit(Translator.new)
puts b2.visit(Evaluator.new)
b3 = BitXorOperation.new(i1, i2)
puts b3.visit(Translator.new)
puts b3.visit(Evaluator.new)
b4 = BitNotOperation.new(i1)
puts b4.visit(Translator.new)
puts b4.visit(Evaluator.new)
b5 = LeftShiftOperation.new(i1, i2)
puts b5.visit(Translator.new)
puts b5.visit(Evaluator.new)
b6 = RightShiftOperation.new(i1, i2)
puts b6.visit(Translator.new)
puts b6.visit(Evaluator.new)

# Relational Operations

x1 = IntegerPrimitive.new(10)
x2 = IntegerPrimitive.new(10)

r1 = EqualsOperation.new(x1, x2)
puts r1.visit(Translator.new)
puts r1.visit(Evaluator.new)
r2 = NotEqualsOperation.new(x1, x2)
puts r2.visit(Translator.new)
puts r2.visit(Evaluator.new)
r3 = LessThanOperation.new(x1, x2)
puts r3.visit(Translator.new)
puts r3.visit(Evaluator.new)
r4 = LessThanOrEqualOperation.new(x1, x2)
puts r4.visit(Translator.new)
puts r4.visit(Evaluator.new)
r5 = GreaterThanOperation.new(x1, x2)
puts r5.visit(Translator.new)
puts r5.visit(Evaluator.new)
r6 = GreaterThanOrEqualOperation.new(x1, x2)
puts r6.visit(Translator.new)
puts r6.visit(Evaluator.new)

# Casting Operations

c1 = IntegerPrimitive.new(9)
c2 = FloatPrimitive.new(4.5)

c3 = FloatToInt.new(c2)
puts c3.visit(Translator.new)
puts c3.visit(Evaluator.new)
c4 = IntToFloat.new(c1)
puts c4.visit(Translator.new)
puts c4.visit(Evaluator.new)

# Other

# o1 = Variables.new(c1)
# o2 = Assignment.new(o1, c1)
o3 = Print.new(a1)
puts o3.visit(Translator.new)
o3.visit(Evaluator.new)