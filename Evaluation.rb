class Evaluator
    def visit_integer(node)
        node
    end

    def visit_add(node)
        node.left + node.right
    end

    def visit_sub(node)
        node.left - node.right
    end

    def visit_add(node)
        node.left * node.right
    end

    def visit_add(node)
        node.left / node.right
    end

    def visit_add(node)
        node.left % node.right
    end

    def visit_add(node)
        node.left ^ node.right
    end

    def visit_neg(node)
        !node
    end
end