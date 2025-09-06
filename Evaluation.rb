class Runtime
    attr_reader :variables
    def initialize()
        @variables = Hash.new
    end
end

class Evaluator
    attr_reader :runtime
    def initialize(runtime)
        @runtime = runtime
    end

    # Primitives

    def visit_integer(node)
        node
    end

    def visit_float(node)
        node
    end

    def visit_boolean(node)
        node
    end

    def visit_string(node)
        node
    end

    def visit_null(node)
        node
    end

    # Arithmetic Operations

    def visit_arithm_add(node)
        left = node.left.visit(self)
        raise 'Invalid type for add' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for add' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value + right.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    def visit_arithm_sub(node)
        left = node.left.visit(self)
        raise 'Invalid type for subtract' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for subtract' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value - right.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    def visit_arithm_mul(node)
        left = node.left.visit(self)
        raise 'Invalid type for multiply' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for multiply' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value * right.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    def visit_arithm_div(node)
        left = node.left.visit(self)
        raise 'Invalid type for divide' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for divide' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value / right.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    def visit_arithm_mod(node)
        left = node.left.visit(self)
        raise 'Invalid type for modulo' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for modulo' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value % right.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    def visit_arithm_exp(node)
        left = node.left.visit(self)
        raise 'Invalid type for exponent' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for exponent' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value ** right.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    def visit_arithm_neg(node)
        value = node.value.visit(self)
        raise 'Invalid type for negation' if (!value.is_a?(IntegerPrimitive) && !value.is_a?(FloatPrimitive))
        result = -value.value
        if result.class == Integer
            return IntegerPrimitive.new(result)
        else 
            return FloatPrimitive.new(result)
        end
    end

    # Logical Operations

    def visit_log_and(node)
        left = node.left.visit(self)
        raise 'Invalid type for logical and' if (!left.is_a?(BooleanPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for logical and' if (!right.is_a?(BooleanPrimitive))
        result = left.value && right.value
        return BooleanPrimitive.new(result)
    end

    def visit_log_or(node)
        left = node.left.visit(self)
        raise 'Invalid type for logical or' if (!left.is_a?(BooleanPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for logical or' if (!right.is_a?(BooleanPrimitive))
        result = left.value && right.value
        return BooleanPrimitive.new(result)
    end

    def visit_log_not(node)
        value = node.value.visit(self)
        raise 'Invalid type for logical not' if (!value.is_a?(BooleanPrimitive))
        result = !value.value
        return BooleanPrimitive.new(result)
    end

    # Bitwise Operations

    def visit_bit_and(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise and' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise and' if (!right.is_a?(IntegerPrimitive))
        result = left.value & right.value
        return IntegerPrimitive.new(result)
    end

    def visit_bit_or(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise or' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise or' if (!right.is_a?(IntegerPrimitive))
        result = left.value | right.value
        return IntegerPrimitive.new(result)
    end

    def visit_bit_xor(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise xor' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise xor' if (!right.is_a?(IntegerPrimitive))
        result = left.value ^ right.value
        return IntegerPrimitive.new(result)
    end

    def visit_bit_not(node)
        value = node.value.visit(self)
        raise 'Invalid type for bitwise not' if (!value.is_a?(IntegerPrimitive))
        result = ~value.value
        return IntegerPrimitive.new(result)
    end

    def visit_left_shift(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise left shift' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise left shift' if (!right.is_a?(IntegerPrimitive))
        result = left.value << right.value
        return IntegerPrimitive.new(result)
    end

    def visit_right_shift(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise right shift' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise right shift' if (!right.is_a?(IntegerPrimitive))
        result = left.value >> right.value
        return IntegerPrimitive.new(result)
    end

    # Relational Operations

    def visit_equals(node)
        left = node.left.visit(self)
        raise 'Invalid type for equals' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for equals' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value == right.value
        return BooleanPrimitive.new(result)
    end

    def visit_not_equals(node)
        left = node.left.visit(self)
        raise 'Invalid type for not equals' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for not equals' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value != right.value
        return BooleanPrimitive.new(result)
    end

    def visit_less_than(node)
        left = node.left.visit(self)
        raise 'Invalid type for less than' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for less than' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value < right.value
        return BooleanPrimitive.new(result)
    end

    def visit_less_than_or_equal(node)
        left = node.left.visit(self)
        raise 'Invalid type for less than equals' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for less than equals' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value <= right.value
        return BooleanPrimitive.new(result)
    end

    def visit_greater_than(node)
        left = node.left.visit(self)
        raise 'Invalid type for greater than' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for greater than' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value > right.value
        return BooleanPrimitive.new(result)
    end

    def visit_greater_than_or_equal(node)
        left = node.left.visit(self)
        raise 'Invalid type for greater than equals' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for greater than equals' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value >= right.value
        return BooleanPrimitive.new(result)
    end

    # Casting Operation

    def visit_float_int(node)
        value = node.value.visit(self)
        raise 'Invalid type for float to int' if (!value.is_a?(FloatPrimitive))
        result = Integer(value.value)
        return IntegerPrimitive.new(result)
    end

    def visit_int_float(node)
        value = node.value.visit(self)
        raise 'Invalid type for int to float' if (!value.is_a?(IntegerPrimitive))
        result = Float(value.value)
        return FloatPrimitive.new(result)
    end

    # Other

    def visit_var(node)
        var = node.value.visit(self)
        raise 'Invalid type for variable' if (!var.is_a?(StringPrimitive))
        return runtime.variables.key?(var.value) ? runtime.variables.fetch(var.value) : nil
    end

    def visit_assign(node)
        left = node.left
        raise 'Invalid type for Assignment' if (!left.is_a?(Variable))
        right = node.right.visit(self)
        if right.value.class == Integer
            result = IntegerPrimitive.new(right.value)
        elsif right.value.class == Float
            result = FloatPrimitive.new(right.value)
        elsif right.value.class == TrueClass || right.value.class == FalseClass
            result = BooleanPrimitve.new(right.value)
        elsif right.value.class == String
            result = StringPrimitive.new(right.value)
        else
            result = NullPrimitive.new
        end
        runtime.variables[left.value.value] = result
        return right.value
    end

    def visit_print(node)
        return nil
    end

    def visit_block(block)
        if block.array.size == 0
            return nil;
        else
            result = nil
            block.array.each do |line|
                result = line.visit(self)
            end
            return result
        end
    end
end