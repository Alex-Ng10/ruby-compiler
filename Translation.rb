class Translator
    def visit_integer(node)
        "#{node.visit(self)}"
    end

    def visit_add(node)
        "#{node.left.visit(self)} + #{node.right.visit(self)}"
    end

    def visit_sub(node)
        "#{node.left.visit(self)} - #{node.right.visit(self)}"
    end

    def visit_mul(node)
        "#{node.left.visit(self)} * #{node.right.visit(self)}"
    end

    def visit_div(node)
        "#{node.left.visit(self)} / #{node.right.visit(self)}"
    end

    def visit_mod(node)
        "#{node.left.visit(self)} % #{node.right.visit(self)}"
    end

    def visit_exp(node)
        "#{node.left.visit(self)} ^ #{node.rightvisit(self)}"
    end

    def visit_neg(node)
        "!#{node.visit(self)}}"
    end
end