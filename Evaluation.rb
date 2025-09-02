class Evaluator
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

    def visit_add(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive)  # raise '+ expect fractions' if !left_primitive.is_a?(AST::FloatPrimitive)
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) + right.visit(self)
    end

    def visit_sub(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) - right.visit(self)
    end

    def visit_mul(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) * right.visit(self)
    end

    def visit_div(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) / right.visit(self)
    end

    def visit_mod(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) % right.visit(self)
    end

    def visit_exp(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) ** right.visit(self)
    end

    # Test
    def visit_neg(node)
        value = node.value
        if (value.class != FloatPrimitive && value.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        -value.visit(Evaluator.new)
    end

    def visit_and(node)
        left = node.left
        if (left.class != BooleanPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != BooleanPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) && right.visit(self)
    end

    def visit_or(node)
        left = node.left
        if (left.class != BooleanPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != BooleanPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) || right.visit(self)
    end

    # Test
    def visit_not(node)
        value = node.value
        if (value.class != BooleanPrimitive) 
            raise "Invalid type"
        end
        !value.visit(Evaluator.new)
    end

    def visit_bit_and(node)
        left = node.left
        if (left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) & right.visit(self)
    end

    def visit_bit_or(node)
        left = node.left
        if (left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) | right.visit(self)
    end

    def visit_bit_xor(node)
        left = node.left
        if (left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) ^ right.visit(self)
    end

    # Test
    def visit_bit_not(node)
        value = node.value
        if (value.class != FloatPrimitive && value.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        ~value.visit(Evaluator.new)
    end

    def visit_left_shift(node)
        left = node.left
        if (left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) << right.visit(self)
    end

    def visit_right_shift(node)
        left = node.left
        if (left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) >> right.visit(self)
    end

    # Relational Operations
    def visit_equals(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) == right.visit(self)
    end

    def visit_not_equals(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) != right.visit(self)
    end

    def visit_less_than(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) < right.visit(self)
    end

    def visit_less_than_or_equal(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) <= right.visit(self)
    end

    def visit_greater_than(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) > right.visit(self)
    end

    def visit_greater_than_or_equal(node)
        left = node.left
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left.visit(self) >= right.visit(self)
    end

    # Casting Operation
    # Test
    def visit_float_int(node)
        value = node.value
        if (value.class != FloatPrimitive && value.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        Integer(value.visit(Evaluator.new))
    end

    # Test
    def visit_int_float(node)
        value = node.value
        if (value.class != FloatPrimitive && value.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        Float(value.visit(Evaluator.new))
    end

end