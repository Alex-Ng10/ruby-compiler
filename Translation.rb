class Translator
    def visit_integer(node)
        "#{node.value}"
    end

    def visit_float(node)
        "#{node.value}"
    end

    def visit_boolean(node)
        "#{node.value}"
    end

    def visit_string(node)
        "#{node.value}"
    end

    def visit_null(node)
        "#{node.value}"
    end
 test here
    # Arithmetic Operations
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
        "#{node.left.visit(self)} ^ #{node.right.visit(self)}"
    end

    def visit_neg(node)
        "-#{node.value.visit(self)}"
    end

    # Logical Operations
    def visit_and(node)
        "#{node.left.visit(self)} && #{node.right.visit(self)}"
    end

    def visit_or(node)
        "#{node.left.visit(self)} || #{node.right.visit(self)}"
    end

    def visit_not(node)
        "!#{node.value.visit(self)}"
    end

    # Bitwise Operations
    def visit_bit_and(node)
        "#{node.left.visit(self)} & #{node.right.visit(self)}"
    end

    def visit_bit_or(node)
        "#{node.left.visit(self)} | #{node.right.visit(self)}"
    end

    def visit_bit_xor(node)
        "#{node.left.visit(self)} ^ #{node.right.visit(self)}"
    end

    def visit_bit_not(node)
        "~#{node.value.visit(self)}"
    end

    def visit_left_shift(node)
        "#{node.left.visit(self)} << #{node.right.visit(self)}"
    end

    def visit_right_shift(node)
        "#{node.left.visit(self)} >> #{node.right.visit(self)}"
    end

    # Relational Operations
    def visit_equals(node)
        "#{node.left.visit(self)} == #{node.right.visit(self)}"
    end

    def visit_not_equals(node)
        "#{node.left.visit(self)} != #{node.right.visit(self)}"
    end

    def visit_less_than(node)
        "#{node.left.visit(self)} < #{node.right.visit(self)}"
    end

    def visit_less_than_or_equal(node)
        "#{node.left.visit(self)} <= #{node.right.visit(self)}"
    end

    def visit_greater_than(node)
        "#{node.left.visit(self)} > #{node.right.visit(self)}"
    end

    def visit_greater_than_or_equal(node)
        "#{node.left.visit(self)} >= #{node.right.visit(self)}"
    end

    # Casting Operations
    def visit_float_int(node)
        "Integer(#{node.value.visit(self)})"
    end

    def visit_int_float(node)
        "Float(#{node.value.visit(self)})"
    end
end