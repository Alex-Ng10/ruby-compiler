require_relative 'Translation'
require_relative 'Evaluation'

class IntegerPrimitive
    attr_reader :value
    def initialize(value)
        @value = Integer(value)
    end

    def visit(visitor)
        visitor.visit_integer(self)
    end
end

class FloatPrimitive
    attr_reader :value
    def initialize(value)
        @value = Float(value)
    end

    def visit(visitor)
        visitor.visit_float(self)
    end
end

class BooleanPrimitive
    attr_reader :value
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

class StringPrimitive
    attr_reader :value
    def initialize(value)
        @value = String(value)
    end

    def visit(visitor)
        visitor.visit_float(self)
    end
end

class NullPrimitive
    attr_reader :value
    def initialize()
        @value = nil
    end

    def visit(visitor)
        visitor.visit_float(self)
    end
end

class AddOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_add(self)
    end
end

class SubtractOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    
    def visit(visitor)
        visitor.visit_sub(self)
    end
end

class MultiplyOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_mul(self)
    end
end

class DivideOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_div(self)
    end
end

class ModuloOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_mod(self)
    end
end

class ExponentOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_exp(self)
    end
end

class NegationOperation
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_neg(self)
    end
end

# Logical Operations

class AndOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_and(self)
    end
end

class OrOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_or(self)
    end
end

class NotOperation
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_not(self)
    end
end

# Bitwise Operations

class BitAndOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_bit_and(self)
    end
end

class BitOrOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_bit_or(self)
    end
end

class BitXorOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_bit_xor(self)
    end
end

class BitNotOperation
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_bit_not(self)
    end
end

class LeftShiftOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_left_shift(self)
    end
end

class RightShiftOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_right_shift(self)
    end
end

# Relational Operations

class EqualsOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_equals(self)
    end
end

class NotEqualsOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_not_equals(self)
    end
end

class LessThanOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_less_than(self)
    end
end

class LessThanOrEqualOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_less_than_or_equal(self)
    end
end

class GreaterThanOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_greater_than(self)
    end
end

class GreaterThanOrEqualOperation
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_greater_than_or_equal(self)
    end
end




# Primitive Operations
a = FloatPrimitive.new(8)
puts a.visit(Translator.new)
puts a.visit(Evaluator.new)
c = BooleanPrimitive.new(nil)
puts c.visit(Translator.new)
puts c.visit(Evaluator.new)
d = StringPrimitive.new("hello there")
puts d.visit(Translator.new)
puts d.visit(Evaluator.new)

# Arithmetic Operations that were tested in a rotation
# b = AddOperation.new(c, d)
# puts b.visit(Translator.new)
# puts b.visit(Evaluator.new)

e = NullPrimitive.new
puts e.visit(Translator.new)
puts e.visit(Evaluator.new)

# Logical operations
f = AndOperation.new(c, c)  # Those are the 3 logical operations that had to be implemented similarly to the exponentiation since they both use 2 boolean values.
puts f.visit(Translator.new)
puts f.visit(Evaluator.new)
g = OrOperation.new(c, c)
puts g.visit(Translator.new)
puts g.visit(Evaluator.new)

h = NotOperation.new(c)     # This works similarly to the negation operation, since we just take a value and apply a negation operation.
puts h.visit(Translator.new)
puts h.visit(Evaluator.new)

# Bitwise Operations
i1 = IntegerPrimitive.new(9)
i2 = IntegerPrimitive.new(3)

b1 = BitAndOperation.new(i1, i2)
b2 = BitOrOperation.new(i1, i2)
b3 = BitXorOperation.new(i1, i2)
b4 = BitNotOperation.new(i1)
b5 = LeftShiftOperation.new(i1, i2)
b6 = RightShiftOperation.new(i1, i2)

puts b1.visit(Translator.new)
puts b1.visit(Evaluator.new)

puts b2.visit(Translator.new)
puts b2.visit(Evaluator.new)

puts b3.visit(Translator.new)
puts b3.visit(Evaluator.new)

puts b4.visit(Translator.new)
puts b4.visit(Evaluator.new)

puts b5.visit(Translator.new)
puts b5.visit(Evaluator.new)

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

