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

a = FloatPrimitive.new(8)
puts a.visit(Translator.new)
puts a.visit(Evaluator.new)
b = NegationOperation.new(a)
puts b.visit(Translator.new)
puts b.visit(Evaluator.new)
c = BooleanPrimitive.new(43568926)
puts c.visit(Translator.new)
puts c.visit(Evaluator.new)
d = StringPrimitive.new("hello there")
puts d.visit(Translator.new)
puts d.visit(Evaluator.new)
e = NullPrimitive.new
puts e.visit(Translator.new)
puts e.visit(Evaluator.new)
