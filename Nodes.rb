require_relative 'Translation'
require_relative 'Evaluation'
require_relative 'Parsing'
require_relative 'Tokenization'
require_relative 'Tokens'

# Class to be used by nodes to simplfy
class One
    attr_reader :value
    def initialize(value)
        @value = value
    end
end

# Class to be used by nodes to simplfy
class Two
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
end

class Three
    attr_reader :left, :middle, :right
    def initialize(left, middle, right)
        @left = left
        @middle = middle
        @right = right
    end
end

class Four
    attr_reader :first, :second, :third, :fourth
    def initialize(first, second, third, fourth)
        @first = first
        @second = second
        @third = third
        @fourth = fourth
    end
end

class IntegerPrimitive < One
    def visit(visitor)
        visitor.visit_integer(self)
    end
end

class FloatPrimitive < One
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

class Conditional
    def initialize(left, middle, right = NullPrimitive.new)
        @left = left
        @middle = middle
        @right = right
    end
    def visit(visitor)
        visitor.visit_conditional(self)
    end
end

class WhileLoop < Two
    def visit(visitor)
        visitor.visit_while_loop(self)
    end
end

class ForEachLoop < Four
    def visit(visitor)
        visitor.visit_for_each_loop(self)
    end
end

class FunctionDefinition
    attr_reader :name, :parameters, :body
    def initialize(name, parameters, body)
        @name = name
        @parameters = parameters
        @body = body
    end
    def visit(visitor)
        visitor.visit_function_definition(self)
    end
end

class FunctionCall
    attr_reader :name, :parameters
    def initialize(name, parameters)
        @name = name
        @parameters = parameters
    end
    def visit(visitor)
        visitor.visit_function_call(self)
    end
end

class Return < One
    def visit(visitor)
        visitor.visit_return(self)
    end
end

# # Primitive Operations

# p1 = IntegerPrimitive.new(8)
# puts p1.visit(Translator.new)
# puts p1.visit(Evaluator.new(Runtime.new)).value
# p2 = FloatPrimitive.new(2.0)
# puts p2.visit(Translator.new)
# puts p2.visit(Evaluator.new(Runtime.new)).value
# p3 = BooleanPrimitive.new(nil)
# puts p3.visit(Translator.new)
# puts p3.visit(Evaluator.new(Runtime.new)).value
# p4 = StringPrimitive.new("hello there")
# puts p4.visit(Translator.new)
# puts p4.visit(Evaluator.new(Runtime.new)).value
# p5 = NullPrimitive.new
# puts p5.visit(Translator.new)
# puts p5.visit(Evaluator.new(Runtime.new)).value

# # Arithmetic Operations

# a1 = AddArithmeticOperation.new(p1, p2)
# puts a1.visit(Translator.new)
# puts a1.visit(Evaluator.new(Runtime.new)).value
# a2 = SubtractArithmeticOperation.new(p1, p2)
# puts a2.visit(Translator.new)
# puts a2.visit(Evaluator.new(Runtime.new)).value
# a3 = MultiplyArithmeticOperation.new(p1, p2)
# puts a3.visit(Translator.new)
# puts a3.visit(Evaluator.new(Runtime.new)).value
# a4 = DivideArithmeticOperation.new(p1, p2)
# puts a4.visit(Translator.new)
# puts a4.visit(Evaluator.new(Runtime.new)).value
# a5 = ModuloArithmeticOperation.new(p1, p2)
# puts a5.visit(Translator.new)
# puts a5.visit(Evaluator.new(Runtime.new)).value
# a6 = ExponentArithmeticOperation.new(p1, p2)
# puts a6.visit(Translator.new)
# puts a6.visit(Evaluator.new(Runtime.new)).value
# a7 = NegationArithmeticOperation.new(p1)
# puts a7.visit(Translator.new)
# puts a7.visit(Evaluator.new(Runtime.new)).value

# # Logical operations

# l1 = AndLogicalOperation.new(p3, p3)  
# puts l1.visit(Translator.new)
# puts l1.visit(Evaluator.new(Runtime.new)).value
# l2 = OrLogicalOperation.new(p3, p3)
# puts l2.visit(Translator.new)
# puts l2.visit(Evaluator.new(Runtime.new)).value
# l3 = NotLogicalOperation.new(p3)
# puts l3.visit(Translator.new)  
# puts l3.visit(Evaluator.new(Runtime.new)).value

# # Bitwise Operations

# i1 = IntegerPrimitive.new(9)
# i2 = IntegerPrimitive.new(3)

# b1 = BitAndOperation.new(i1, i2)
# puts b1.visit(Translator.new)
# puts b1.visit(Evaluator.new(Runtime.new)).value
# b2 = BitOrOperation.new(i1, i2)
# puts b2.visit(Translator.new)
# puts b2.visit(Evaluator.new(Runtime.new)).value
# b3 = BitXorOperation.new(i1, i2)
# puts b3.visit(Translator.new)
# puts b3.visit(Evaluator.new(Runtime.new)).value
# b4 = BitNotOperation.new(i1)
# puts b4.visit(Translator.new)
# puts b4.visit(Evaluator.new(Runtime.new)).value
# b5 = LeftShiftOperation.new(i1, i2)
# puts b5.visit(Translator.new)
# puts b5.visit(Evaluator.new(Runtime.new)).value
# b6 = RightShiftOperation.new(i1, i2)
# puts b6.visit(Translator.new)
# puts b6.visit(Evaluator.new(Runtime.new)).value

# # Relational Operations

# x1 = IntegerPrimitive.new(10)
# x2 = IntegerPrimitive.new(10)

# r1 = EqualsOperation.new(x1, x2)
# puts r1.visit(Translator.new)
# puts r1.visit(Evaluator.new(Runtime.new)).value
# r2 = NotEqualsOperation.new(x1, x2)
# puts r2.visit(Translator.new)
# puts r2.visit(Evaluator.new(Runtime.new)).value
# r3 = LessThanOperation.new(x1, x2)
# puts r3.visit(Translator.new)
# puts r3.visit(Evaluator.new(Runtime.new)).value
# r4 = LessThanOrEqualOperation.new(x1, x2)
# puts r4.visit(Translator.new)
# puts r4.visit(Evaluator.new(Runtime.new)).value
# r5 = GreaterThanOperation.new(x1, x2)
# puts r5.visit(Translator.new)
# puts r5.visit(Evaluator.new(Runtime.new)).value
# r6 = GreaterThanOrEqualOperation.new(x1, x2)
# puts r6.visit(Translator.new)
# puts r6.visit(Evaluator.new(Runtime.new)).value

# # Casting Operations

# c1 = IntegerPrimitive.new(9)
# c2 = FloatPrimitive.new(4.5)

# c3 = FloatToInt.new(c2)
# puts c3.visit(Translator.new)
# puts c3.visit(Evaluator.new(Runtime.new)).value
# c4 = IntToFloat.new(c1)
# puts c4.visit(Translator.new)
# puts c4.visit(Evaluator.new(Runtime.new)).value

# # Other Operations

# o1 = StringPrimitive.new("hi")

# o2 = Variable.new(o1)
# puts o2.visit(Translator.new)
# puts o2.visit(Evaluator.new(Runtime.new))
# o3 = Assignment.new(o2, a1)
# puts o3.visit(Translator.new)
# puts o3.visit(Evaluator.new(Runtime.new))
# o4 = Print.new(a1)
# puts o4.visit(Translator.new)
# puts o4.visit(Evaluator.new(Runtime.new))
# o5 = Block.new([o2, o3, o2])
# puts o5.visit(Translator.new)
# puts o5.visit(Evaluator.new(Runtime.new))

# # Extra

# o6 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("x")), IntegerPrimitive.new(9)), Assignment.new(Variable.new(StringPrimitive.new("y")), MultiplyArithmeticOperation.new(Variable.new(StringPrimitive.new("x")), IntegerPrimitive.new(9))), Assignment.new(Variable.new(StringPrimitive.new("y")), MultiplyArithmeticOperation.new(Variable.new(StringPrimitive.new("y")), IntegerPrimitive.new(9)))])
# puts o6.visit(Translator.new)
# puts o6.visit(Evaluator.new(Runtime.new))

# r1 = AddArithmeticOperation.new(AddArithmeticOperation.new(IntegerPrimitive.new(5),FloatPrimitive.new(10.5)),SubtractArithmeticOperation.new(BitOrOperation.new(IntegerPrimitive.new(6),IntegerPrimitive.new(12)),BitAndOperation.new(IntegerPrimitive.new(5),IntegerPrimitive.new(3))))
# puts r1.visit(Translator.new)
# puts r1.visit(Evaluator.new(Runtime.new)).value

# # Demonstration

# puts "Arithmetic: (7 * 4 + 3) % 12"
# d1 = ModuloArithmeticOperation.new(AddArithmeticOperation.new(MultiplyArithmeticOperation.new(IntegerPrimitive.new(7), IntegerPrimitive.new(4)), IntegerPrimitive.new(3)), IntegerPrimitive.new(12))
# puts d1.visit(Translator.new)
# puts d1.visit(Evaluator.new(Runtime.new)).value

# puts "Arithmetic negation and rvalues: a * b"
# d2 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("a")), IntegerPrimitive.new(9)), Assignment.new(Variable.new(StringPrimitive.new("b")), IntegerPrimitive.new(3)), MultiplyArithmeticOperation.new(Variable.new(StringPrimitive.new("a")), Variable.new(StringPrimitive.new("b")))])
# puts d2.visit(Translator.new)
# puts d2.visit(Evaluator.new(Runtime.new))

# puts "Rvalue lookup and shift: i << 3"
# d3 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("i")), IntegerPrimitive.new(7)), LeftShiftOperation.new(Variable.new(StringPrimitive.new("i")), IntegerPrimitive.new(3))])
# puts d3.visit(Translator.new)
# puts d3.visit(Evaluator.new(Runtime.new))

# puts "Rvalue lookup and comparison: j == j + 0"
# d4 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("j")), IntegerPrimitive.new(42)), EqualsOperation.new(Variable.new(StringPrimitive.new("j")), AddArithmeticOperation.new(Variable.new(StringPrimitive.new("j")), IntegerPrimitive.new(0)))])
# puts d4.visit(Translator.new)
# puts d4.visit(Evaluator.new(Runtime.new))

# puts "Logic and comparison: !(3.3 > 3.2)"
# d5 = NotLogicalOperation.new(GreaterThanOperation.new(FloatPrimitive.new(3.3), FloatPrimitive.new(3.2)))
# puts d5.visit(Translator.new)
# puts d5.visit(Evaluator.new(Runtime.new)).value

# puts "Double negation: --(6 * 8)"
# d6 = NegationArithmeticOperation.new(NegationArithmeticOperation.new(MultiplyArithmeticOperation.new(IntegerPrimitive.new(6), IntegerPrimitive.new(8))))
# puts d6.visit(Translator.new)
# puts d6.visit(Evaluator.new(Runtime.new)).value

# puts "Bitwise operations: ~5 | ~8"
# d7 = BitOrOperation.new(BitNotOperation.new(IntegerPrimitive.new(5)), BitNotOperation.new(IntegerPrimitive.new(8)))
# puts d7.visit(Translator.new)
# puts d7.visit(Evaluator.new(Runtime.new)).value

# puts "Casting: float(7) / 2"
# d8 = DivideArithmeticOperation.new(IntToFloat.new(IntegerPrimitive.new(7)), IntegerPrimitive.new(2))
# puts d8.visit(Translator.new)
# puts d8.visit(Evaluator.new(Runtime.new)).value

# puts "Assignment: n = 9 & 3"
# d9 = Assignment.new(Variable.new(StringPrimitive.new("n")), BitAndOperation.new(IntegerPrimitive.new(9), IntegerPrimitive.new(3)))
# puts d9.visit(Translator.new)
# puts d9.visit(Evaluator.new(Runtime.new))

# d10 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("x")), IntegerPrimitive.new(17)), Variable.new(StringPrimitive.new("x"))])
# puts d10.visit(Translator.new)
# puts d10.visit(Evaluator.new(Runtime.new))

# d11 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("count")), LeftShiftOperation.new(IntegerPrimitive.new(6), IntegerPrimitive.new(1))), Assignment.new(Variable.new(StringPrimitive.new("delta")), IntegerPrimitive.new(3)), Assignment.new(Variable.new(StringPrimitive.new("count")), AddArithmeticOperation.new(Variable.new(StringPrimitive.new("count")), Variable.new(StringPrimitive.new("delta")))), Variable.new(StringPrimitive.new("count"))])
# puts d11.visit(Translator.new)
# puts d11.visit(Evaluator.new(Runtime.new))

# d12 = Block.new([Assignment.new(Variable.new(StringPrimitive.new("n")), IntegerPrimitive.new(18)), LessThanOrEqualOperation.new(Variable.new(StringPrimitive.new("n")), IntegerPrimitive.new(18)), AndLogicalOperation.new(LessThanOrEqualOperation.new(IntegerPrimitive.new(13), Variable.new(StringPrimitive.new("n"))), LessThanOrEqualOperation.new(Variable.new(StringPrimitive.new("n")), IntegerPrimitive.new(16))), NegationArithmeticOperation.new(ExponentArithmeticOperation.new(Variable.new(StringPrimitive.new("n")), IntegerPrimitive.new(2)))])
# puts d12.visit(Translator.new)
# puts d12.visit(Evaluator.new(Runtime.new))

# d13 = LeftShiftOperation.new(FloatPrimitive.new(7.5), IntegerPrimitive.new(2))
# puts d13.visit(Translator.new)
# puts d13.visit(Evaluator.new(Runtime.new))

# d14 = GreaterThanOrEqualOperation.new(BooleanPrimitive.new(true), IntegerPrimitive.new(10))
# puts d14.visit(Translator.new)
# puts d14.visit(Evaluator.new(Runtime.new))

# d15 = DivideArithmeticOperation.new(StringPrimitive.new("fooo"), IntegerPrimitive.new(3))
# puts d15.visit(Translator.new)
# puts d15.visit(Evaluator.new(Runtime.new))

# d16 = NotLogicalOperation.new(IntegerPrimitive.new(18))
# puts d16.visit(Translator.new)
# puts d16.visit(Evaluator.new(Runtime.new))

# d17 = SubtractArithmeticOperation.new(StringPrimitive.new("hello"), IntegerPrimitive.new(42))
# puts d17.visit(Translator.new)
# puts d17.visit(Evaluator.new(Runtime.new))

# d18 = AndLogicalOperation.new(StringPrimitive.new("something"), BooleanPrimitive.new(false))
# puts d18.visit(Translator.new)
# puts d18.visit(Evaluator.new(Runtime.new))

l1 = Lexer.new(gets.chomp)
puts "Here are the tokens: #{l1.tokens}"
p1 = Parser.new(l1.tokens)
puts r1 = p1.parse
# puts r1.visit(Translator.new)
puts r1.visit(Evaluator.new(Runtime.new))

# if __FILE__ == $0                           # Guard necessary to use mystery files
#   l1 = Lexer.new(gets.chomp)             
#   p1 = Parser.new(l1.tokens)            
#   puts r1 = p1.parse
#   puts r1.visit(Translator.new)
#   puts r1.visit(Evaluator.new(Runtime.new))
# end

# $ 5 + 2, $ 10 * 6 - 10 % 4, $ (5 + 2) * 3 % 4, $ @6, $ 2 ** 9, $ 45 & ~~~(1 + 3), 9 << 1
# $ 8 >= 7 + 1, $ !!!!f, $ t || !f, $ (5 > 3) && !(2 > 8)
# x = 5, $ x + x * x, x = 999, $ x

# Tests

# i1 = IntegerPrimitive.new(8)
# i2 = IntegerPrimitive.new(8)
# r1 = EqualsOperation.new(i1, i2)
# b1 = Block.new([IntegerPrimitive.new(3), IntegerPrimitive.new(2), IntegerPrimitive.new(1)])
# puts b1.visit(Translator.new)
# b2 = Block.new([IntegerPrimitive.new(1), IntegerPrimitive.new(2), IntegerPrimitive.new(3)])
# puts b2.visit(Translator.new)
# c1 = Conditional.new(r1, b1, b2)
# puts c1.visit(Translator.new)
# puts c1.visit(Evaluator.new(Runtime.new))
# c1 = Conditional.new(r1, b1)
# puts c1.visit(Translator.new)
# puts c1.visit(Evaluator.new(Runtime.new))

# l1 = WhileLoop.new(r1, b1)
# puts l1.visit(Translator.new)
# puts l1.visit(Evaluator.new(Runtime.new))

# s1 = StringPrimitive.new("a")
# v1 = Variable.new(s1)
# l2 = ForEachLoop.new(v1, i1, i2, b1)
# puts l2.visit(Translator.new)
# puts l2.visit(Evaluator.new(Runtime.new))

# fd1 = FunctionDefintion.new(StringPrimitive.new("Something"), [Variable.new(StringPrimitive.new("a")), Variable.new(StringPrimitive.new("b"))], b1)
# fd2 = FunctionDefintion.new(StringPrimitive.new("Something"), [Variable.new(StringPrimitive.new("a"))], b1)
# fd3 = FunctionDefintion.new(StringPrimitive.new("Something"), [], b1)
# puts fd1.visit(Translator.new)
# puts fd1.visit(Evaluator.new(Runtime.new))
# puts fd2.visit(Translator.new)
# puts fd2.visit(Evaluator.new(Runtime.new))
# puts fd3.visit(Translator.new)
# puts fd3.visit(Evaluator.new(Runtime.new))

# fc1 = FunctionCall.new(StringPrimitive.new("Something"), [IntegerPrimitive.new(1), IntegerPrimitive.new(2)])
# fc2 = FunctionCall.new(StringPrimitive.new("Something"), [IntegerPrimitive.new(1)])
# fc3 = FunctionCall.new(StringPrimitive.new("Something"), [])
# puts fc1.visit(Translator.new)
# puts fc1.visit(Evaluator.new(Runtime.new))
# puts fc2.visit(Translator.new)
# puts fc2.visit(Evaluator.new(Runtime.new))
# puts fc3.visit(Translator.new)
# puts fc3.visit(Evaluator.new(Runtime.new))

# t1 = Block.new([fd1, fc1])
# puts t1.visit(Translator.new)
# puts t1.visit(Evaluator.new(Runtime.new))
