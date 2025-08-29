require_relative 'Translation'
require_relative 'Evaluation'

class IntegerPrimitive
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_integer(self)
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