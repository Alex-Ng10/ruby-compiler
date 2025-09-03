class Evaluator

    # Primitives

    def visit_integer(node)
        node.value
    end

    def visit_float(node)
        node.value
    end

    def visit_boolean(node)
        node.value
    end

    def visit_string(node)
        node.value
    end

    def visit_null(node)
        node.value
    end

    # Arithmetic Operations

    def visit_arithm_add(node)
        left = node.left
        raise 'Invalid type for add' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for add' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) + right.visit(self)
    end

    def visit_arithm_sub(node)
        left = node.left
        raise 'Invalid type for subtract' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for subtract' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) - right.visit(self)
    end

    def visit_arithm_mul(node)
        left = node.left
        raise 'Invalid type for multiply' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for multiply' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) * right.visit(self)
    end

    def visit_arithm_div(node)
        left = node.left
        raise 'Invalid type for divide' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for divide' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) / right.visit(self)
    end

    def visit_arithm_mod(node)
        left = node.left
        raise 'Invalid type for modulo' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for modulo' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) % right.visit(self)
    end

    def visit_arithm_exp(node)
        left = node.left
        raise 'Invalid type for exponent' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for exponent' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) ** right.visit(self)
    end

    def visit_arithm_neg(node)
        value = node.value
        raise 'Invalid type for negation' if (value.class != FloatPrimitive && value.class != IntegerPrimitive)
        -value.visit(Evaluator.new)
    end

    # Logical Operations

    def visit_log_and(node)
        left = node.left
        raise 'Invalid type for and' if (left.class != BooleanPrimitive)
        right = node.right
        raise 'Invalid type for and' if (right.class != BooleanPrimitive)
        left.visit(self) && right.visit(self)
    end

    def visit_log_or(node)
        left = node.left
        raise 'Invalid type for or' if (left.class != BooleanPrimitive)
        right = node.right
        raise 'Invalid type for or' if (right.class != BooleanPrimitive)
        left.visit(self) || right.visit(self)
    end

    def visit_log_not(node)
        value = node.value
        raise 'Invalid type for not' if (value.class != BooleanPrimitive)
        !value.visit(Evaluator.new)
    end

    # Bitwise Operations

    def visit_bit_and(node)
        left = node.left
        raise 'Invalid type for and' if (left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for and' if (right.class != IntegerPrimitive)
        left.visit(self) & right.visit(self)
    end

    def visit_bit_or(node)
        left = node.left
        raise 'Invalid type for or' if (left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for or' if (right.class != IntegerPrimitive)
        left.visit(self) | right.visit(self)
    end

    def visit_bit_xor(node)
        left = node.left
        raise 'Invalid type for xor' if (left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for xor' if (right.class != IntegerPrimitive)
        left.visit(self) ^ right.visit(self)
    end

    def visit_bit_not(node)
        value = node.value
        raise 'Invalid type for not' if (value.class != IntegerPrimitive)
        ~value.visit(Evaluator.new)
    end

    def visit_left_shift(node)
        left = node.left
        raise 'Invalid type for left shift' if (left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for left shift' if (right.class != IntegerPrimitive)
        left.visit(self) << right.visit(self)
    end

    def visit_right_shift(node)
        left = node.left
        raise 'Invalid type for right shift' if (left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for right shift' if (right.class != IntegerPrimitive)
        left.visit(self) >> right.visit(self)
    end

    # Relational Operations

    def visit_equals(node)
        left = node.left
        raise 'Invalid type for equals' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for equals' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) == right.visit(self)
    end

    def visit_not_equals(node)
        left = node.left
        raise 'Invalid type for not equals' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for not equals' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) != right.visit(self)
    end

    def visit_less_than(node)
        left = node.left
        raise 'Invalid type for less than' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for less than' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) < right.visit(self)
    end

    def visit_less_than_or_equal(node)
        left = node.left
        raise 'Invalid type for less than equals' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for less than equals' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) <= right.visit(self)
    end

    def visit_greater_than(node)
        left = node.left
        raise 'Invalid type for greater than' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for greater than' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) > right.visit(self)
    end

    def visit_greater_than_or_equal(node)
        left = node.left
        raise 'Invalid type for greater than equals' if (left.class != FloatPrimitive && left.class != IntegerPrimitive)
        right = node.right
        raise 'Invalid type for greater than equals' if (right.class != FloatPrimitive && right.class != IntegerPrimitive)
        left.visit(self) >= right.visit(self)
    end

    # Casting Operation

    def visit_float_int(node)
        value = node.value
        raise 'Invalid type for float to int' if (value.class != FloatPrimitive && value.class != IntegerPrimitive)
        Integer(value.visit(Evaluator.new))
    end

    def visit_int_float(node)
        value = node.value
        raise 'Invalid type for int to float' if (value.class != FloatPrimitive && value.class != IntegerPrimitive)
        Float(value.visit(Evaluator.new))
    end

end