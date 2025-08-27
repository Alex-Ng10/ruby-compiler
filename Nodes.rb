require_relative 'Translation'

class Integer
    attr_reader :value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_integer(self)
    end
end

class Add
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_add(self)
    end
end

class Subtract
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end
    
    def visit(visitor)
        visitor.visit_sub(self)
    end
end

class Multiply
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_mul(self)
    end
end

class Divide
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_div(self)
    end
end

class Modulo
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_mod(self)
    end
end

class Exponent
    attr_reader :left, :right
    def initialize(left, right)
        @left = left
        @right = right
    end

    def visit(visitor)
        visitor.visit_exp(self)
    end
end

class Negation
    attr_reader: value
    def initialize(value)
        @value = value
    end

    def visit(visitor)
        visitor.visit_neg(self)
    end
end