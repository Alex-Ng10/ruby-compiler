class Evaluator
    def visit_integer(node)
        node.value
    end

    def visit_add(node)
        left = node.left.visit(Evaluator.new)
        right = node.right.visit(Evaluator.new)
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
end