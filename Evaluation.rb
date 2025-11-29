class Runtime
    attr_reader :variables, :functions
    def initialize()
        @variables = Hash.new    # stores runtime bindings: name (String) -> Primitive node
        @functions = Hash.new
    end
end

class Evaluator
    attr_reader :runtime
    def initialize(runtime)
        @runtime = runtime      # runtime is shared state for variables
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
    # Note for milestone video: I had to change the concatenation of the Evaluation Add so that it would accept strings. 
    def visit_arithm_add(node)
        left = node.left.visit(self)
        right = node.right.visit(self)

        # Allow string concatenation
        if left.is_a?(StringPrimitive) && right.is_a?(StringPrimitive)
            return StringPrimitive.new(left.value + right.value)
        end

        # Existing logic for numbers
        raise 'Invalid type for add' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        raise 'Invalid type for add' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        
        result = left.value + right.value  
        if result.class == Integer            # distinguish integer vs float result
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
        result = left.value && right.value   # standard Ruby boolean && 
        return BooleanPrimitive.new(result)
    end

    def visit_log_or(node)
        left = node.left.visit(self)
        raise 'Invalid type for logical or' if (!left.is_a?(BooleanPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for logical or' if (!right.is_a?(BooleanPrimitive))
        result = left.value || right.value
        return BooleanPrimitive.new(result)
    end

    def visit_log_not(node)
        value = node.value.visit(self)
        raise 'Invalid type for logical not' if (!value.is_a?(BooleanPrimitive))
        result = !value.value               # logical negation
        return BooleanPrimitive.new(result)
    end

    # Bitwise Operations

    def visit_bit_and(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise and' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise and' if (!right.is_a?(IntegerPrimitive))
        result = left.value & right.value   # bitwise AND on raw integers
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
        result = ~value.value                # bitwise NOT
        return IntegerPrimitive.new(result)
    end

    def visit_left_shift(node)
        left = node.left.visit(self)
        raise 'Invalid type for bitwise left shift' if (!left.is_a?(IntegerPrimitive))
        right = node.right.visit(self)
        raise 'Invalid type for bitwise left shift' if (!right.is_a?(IntegerPrimitive))
        result = left.value << right.value   # shift using Ruby semantics
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
        # raise 'Invalid type for equals' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        # raise 'Invalid type for equals' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
        result = left.value == right.value   # numeric equality
        return BooleanPrimitive.new(result)
    end

    def visit_not_equals(node)
        left = node.left.visit(self)
        # raise 'Invalid type for not equals' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
        right = node.right.visit(self)
        # raise 'Invalid type for not equals' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
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
        result = Integer(value.value)    # explicit cast using Ruby Integer()
        return IntegerPrimitive.new(result)
    end

    def visit_int_float(node)
        value = node.value.visit(self)
        raise 'Invalid type for int to float' if (!value.is_a?(IntegerPrimitive))
        result = Float(value.value)      # explicit cast using Ruby Float()
        return FloatPrimitive.new(result)
    end

    # Other

    def visit_var(node)
        var = node
        raise 'Invalid type for variable' if (!var.is_a?(Variable))
        # return stored primitive node or NullPrimitive when missing
        return runtime.variables.key?(var.value) ? runtime.variables.fetch(var.value) : NullPrimitive.new
    end

    def visit_assign(node)
        left = node.left
        raise 'Invalid type for Assignment' if (!left.is_a?(Variable))
        right = node.right.visit(self)
        # store evaluated primitive node into runtime
        runtime.variables[left.value] = right
        return right
    end

    def visit_print(node)
        puts node.value.visit(self).value   # print raw value of evaluated expression
        return NullPrimitive.new            # printing returns null to the language
    end

    def visit_block(block)
        if block.array.size == 0
            return NullPrimitive.new;
        else
            last = nil
            # Evaluate each line in order and keep last result
            block.array.each do |line|
                last = line.visit(self)
            end
            # If last is a node, extract its .value, otherwise it's already a raw value
            result = last.respond_to?(:visit) ? last.value : last
            return result
        end
    end

    def visit_conditional(node)
        left = node.left.visit(self)
        raise 'Invalid type for conditional' if (!left.is_a?(BooleanPrimitive))
        middle = node.middle
        right = node.right
        if left.value == true
            return middle.visit(self)
        else
            return right.visit(self)
        end
    end

    def visit_while_loop(node)
        left = node.left
        # FIX: Run while the condition is TRUE, not false
        while left.visit(self).value == true
            node.right.visit(self)
        end
        return NullPrimitive.new
    end

    def visit_for_each_loop(node)
        var_node = node.first
        raise 'Invalid loop variable' unless var_node.is_a?(Variable)
        
        start_val = node.second.visit(self)
        raise 'Invalid start value' unless start_val.is_a?(IntegerPrimitive)
        
        end_val = node.third.visit(self)
        raise 'Invalid end value' unless end_val.is_a?(IntegerPrimitive)
        
        block = node.fourth
        
        (start_val.value..end_val.value).each do |i|
            # Arithmetic Operations
            # Note for milestone video: I had to change the concatenation of the Evaluation Add so that it would accept strings. 
            def visit_arithm_add(node)
                left = node.left.visit(self)
                right = node.right.visit(self)
        
                # Allow string concatenation
                if left.is_a?(StringPrimitive) && right.is_a?(StringPrimitive)
                    return StringPrimitive.new(left.value + right.value)
                end
        
                # Existing logic for numbers
                raise 'Invalid type for add' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
                raise 'Invalid type for add' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
                
                result = left.value + right.value  
                if result.class == Integer            # distinguish integer vs float result
                    return IntegerPrimitive.new(result)
                else 
                    return FloatPrimitive.new(result)
                end
            end
            # Arithmetic Operations
            # Note for milestone video: I had to change the concatenation of the Evaluation Add so that it would accept strings. 
            def visit_arithm_add(node)
                left = node.left.visit(self)
                right = node.right.visit(self)
        
                # Allow string concatenation
                if left.is_a?(StringPrimitive) && right.is_a?(StringPrimitive)
                    return StringPrimitive.new(left.value + right.value)
                end
        
                # Existing logic for numbers
                raise 'Invalid type for add' if (!left.is_a?(IntegerPrimitive) && !left.is_a?(FloatPrimitive))
                raise 'Invalid type for add' if (!right.is_a?(IntegerPrimitive) && !right.is_a?(FloatPrimitive))
                
                result = left.value + right.value  
                if result.class == Integer
                    return IntegerPrimitive.new(result)
                else 
                    return FloatPrimitive.new(result)
                end
            end
            # Update loop variable
            runtime.variables[var_node.value] = IntegerPrimitive.new(i)
            # Execute block
            block.visit(self)
        end
        
        return NullPrimitive.new
    end

    def visit_function_definition(node)
        # Store the function definition in the runtime
        # We store the parameters and the body
        runtime.functions[node.name.value] = {
            parameters: node.parameters,
            body: node.body
        }
        return NullPrimitive.new
    end

    def visit_function_call(node)
        name = node.name
        raise 'Invalid type for function call' if (!name.is_a?(Variable))
        
        if runtime.functions.key?(name.value)
            func_def = runtime.functions[name.value]
            params_def = func_def[:parameters]
            args_val = node.parameters
            
            # 1. Create a NEW Runtime for the function (Scope Isolation)
            func_runtime = Runtime.new
            # Copy existing functions so we can call them recursively
            func_runtime.functions.merge!(runtime.functions)
            
            # 2. Bind parameters in the NEW runtime
            # We evaluate arguments in the CURRENT scope (self), but store them in the NEW scope
            params_def.each_with_index do |param_var, index|
                if index < args_val.length
                    val = args_val[index].visit(self) # Evaluate arg
                    func_runtime.variables[param_var.value] = val # Store in function scope
                end
            end
            
            # 3. Execute body using a NEW Evaluator attached to the function runtime
            func_evaluator = Evaluator.new(func_runtime)
            
            result = catch(:result) do
                func_def[:body].visit(func_evaluator)
                NullPrimitive.new
            end
            return result
        else
            raise "Function #{name.value} not defined"
        end
    end

    def visit_return(node)
        result = node.value.visit(self)
        throw :result, result
    end
end