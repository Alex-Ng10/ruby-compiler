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
        left = node.left.visit(Evaluator.new)
        if (left.class != FloatPrimitive && left.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        right = node.right.visit(Evaluator.new)
        if (right.class != FloatPrimitive && right.class != IntegerPrimitive) 
            raise "Invalid type"
        end
        left + right
    end

    def visit_sub(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left - right
    end

    def visit_mul(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left * right
    end

    def visit_div(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left / right
    end

    def visit_mod(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left % right
    end

    def visit_exp(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left ** right
    end

    def visit_neg(node)
        value = node.value.visit(Evaluator.new)
        -value
    end

    def visit_and(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left && right
    end

    def visit_or(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left || right
    end

    def visit_not(node)
        value = node.value.visit(Evaluator.new)
        !value
    end

    def visit_bit_and(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new) 
        # How do we have to put the if statement here
        left & right
    end

    def visit_bit_or(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        # How do we have to put the if statement here
        left | right
    end

    def visit_bit_xor(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        # How do we have to put the if statement here
        left ^ right
    end

    def visit_bit_not(node)
        value = node.value.visit(Evaluator.new)
        # How do we have to put the if statement here
        ~value
    end

    def visit_left_shift(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        # How do we have to put the if statement here
        left << right
    end

    def visit_right_shift(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        # How do we have to put the if statement here
        left >> right
    end

    # Relational Operations
    def visit_equals(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left == right
    end

    def visit_not_equals(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left != right
    end

    def visit_less_than(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left < right
    end

    def visit_less_than_or_equal(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left <= right
    end

    def visit_greater_than(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left > right
    end

    def visit_greater_than_or_equal(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
        left >= right
    end

end