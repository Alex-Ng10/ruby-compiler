class Translator

    # Primitives

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

    # Arithmetic Operations

    def visit_arithm_add(node)
        "(#{node.left.visit(self)} + #{node.right.visit(self)})" 
    end

    def visit_arithm_sub(node)
        "(#{node.left.visit(self)} - #{node.right.visit(self)})"
    end

    def visit_arithm_mul(node)
        "(#{node.left.visit(self)} * #{node.right.visit(self)})"
    end

    def visit_arithm_div(node)
        "(#{node.left.visit(self)} / #{node.right.visit(self)})"
    end

    def visit_arithm_mod(node)
        "(#{node.left.visit(self)} % #{node.right.visit(self)})"
    end

    def visit_arithm_exp(node)
        "(#{node.left.visit(self)} ** #{node.right.visit(self)})"
    end

    def visit_arithm_neg(node)
        "-(#{node.value.visit(self)})"
    end

    # Logical Operations

    def visit_log_and(node)
        "(#{node.left.visit(self)} && #{node.right.visit(self)})"
    end

    def visit_log_or(node)
        "(#{node.left.visit(self)} || #{node.right.visit(self)})"
    end

    def visit_log_not(node)
        "!(#{node.value.visit(self)})"
    end

    # Bitwise Operations

    def visit_bit_and(node)
        "(#{node.left.visit(self)} & #{node.right.visit(self)})"
    end

    def visit_bit_or(node)
        "(#{node.left.visit(self)} | #{node.right.visit(self)})"
    end

    def visit_bit_xor(node)
        "(#{node.left.visit(self)} ^ #{node.right.visit(self)})"
    end

    def visit_bit_not(node)
        "~(#{node.value.visit(self)})"
    end

    def visit_left_shift(node)
        "(#{node.left.visit(self)} << #{node.right.visit(self)})"
    end

    def visit_right_shift(node)
        "(#{node.left.visit(self)} >> #{node.right.visit(self)})"
    end

    # Relational Operations

    def visit_equals(node)
        "(#{node.left.visit(self)} == #{node.right.visit(self)})"
    end

    def visit_not_equals(node)
        "(#{node.left.visit(self)} != #{node.right.visit(self)})"
    end

    def visit_less_than(node)
        "(#{node.left.visit(self)} < #{node.right.visit(self)})"
    end

    def visit_less_than_or_equal(node)
        "(#{node.left.visit(self)} <= #{node.right.visit(self)})"
    end

    def visit_greater_than(node)
        "(#{node.left.visit(self)} > #{node.right.visit(self)})"
    end

    def visit_greater_than_or_equal(node)
        "(#{node.left.visit(self)} >= #{node.right.visit(self)})"
    end

    # Casting Operations

    def visit_float_int(node)
        "Integer(#{node.value.visit(self)})"
    end

    def visit_int_float(node)
        "Float(#{node.value.visit(self)})"
    end

    # Other

    def visit_var(node)
        "#{node.value.visit(self)}"
    end

    def visit_assign(node)
        "#{node.left.visit(self)} = #{node.right.visit(self)}"
    end

    def visit_print(node)
        "print #{node.value.visit(self)}"
    end

    def visit_block(block)
        result = []
        # Repeatly stores a line from the block in an array
        block.array.each do |line|
            result.push("#{line.visit(self)}\n")
        end
        return result
    end

    def visit_conditional(node)
        "if #{node.left.visit(self)}\n#{node.middle.visit(self).join}else\n#{Array(node.right.visit(self)).join}"
    end

    def visit_while_loop(node)
        "while #{node.left.visit(self)}\n#{node.right.visit(self).join}"
    end

    def visit_for_each_loop(node)
        "for #{node.first.visit(self)} in [#{node.second.visit(self)}, #{node.third.visit(self)}]\n#{node.fourth.visit(self).join}"
    end

    def visit_function_defintion(node)
        "function #{node.name.visit(self)} (#{node.parameters.map{|parameter| parameter.visit(self)}.join(", ")})\n#{node.body.visit(self).join}"
    end

    def visit_function_call(node)
        "function #{node.name.visit(self)} (#{node.parameters.map{|parameter| parameter.visit(self)}.join(", ")})"
    end

    def visit_return(node)
        "return #{node.value}"
    end
end