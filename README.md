# Ruby Compiler

A Ruby compiler implementation developed as a team project to deepen understanding of the Ruby programming language, compiler design principles, and collaborative development practices.

## Project Goal

The goal of this repository is to create a fully functional Ruby compiler, develop our skills and understanding of the programming language Ruby, and further improve our team working skills.

---

## How It Works

### Architecture Overview

The Ruby Compiler follows a classic three-stage compilation pipeline:

```
Ruby Source Code → Tokenization → Parsing → Evaluation → Output/Result
```

Each stage transforms the code into a progressively more interpretable form, culminating in execution.

---

## Compilation Stages

### 1. **Tokenization** (`Tokenization.rb`)
The tokenizer breaks down raw Ruby source code into a stream of meaningful tokens (lexical analysis).

**Tokens include:**
- Keywords (if, else, while, def, return, etc.)
- Operators (arithmetic, logical, comparison, assignment)
- Literals (strings, numbers, symbols)
- Identifiers (variable and method names)
- Delimiters (parentheses, brackets, braces)
- Comments (stripped during this phase)

**Example:**
```ruby
# Input code
x = 5 + 3

# Tokens produced
[IDENTIFIER("x"), ASSIGN, NUMBER(5), PLUS, NUMBER(3)]
```

---

### 2. **Parsing** (`Parsing.rb` + `Nodes.rb`)
The parser converts the token stream into an Abstract Syntax Tree (AST) that represents the program's structure (syntax analysis).

**Supported grammar includes:**
- Variable assignments
- Arithmetic and logical expressions
- Control flow (if/else, while, for loops)
- Method/function definitions
- Method calls and arguments
- Return statements
- Operators with correct precedence

**Node types** (from `Nodes.rb`):
- `AssignmentNode` - Variable assignment
- `BinaryOpNode` - Binary operations (+, -, *, /, etc.)
- `IfNode` - Conditional statements
- `WhileNode` - Loop statements
- `MethodDefNode` - Method definitions
- `MethodCallNode` - Method invocations
- `ReturnNode` - Return statements
- `LiteralNode` - Numbers, strings, symbols

**Example AST Structure:**
```
Input:  if x > 5; puts "big"; end
AST:    IfNode(condition: BinaryOpNode(x, >, 5), 
              body: MethodCallNode(puts, "big"))
```

---

### 3. **Evaluation** (`Evaluation.rb`)
The evaluator recursively processes the AST and executes the program (interpretation/execution).

**Responsibilities:**
- Maintain variable scope and memory
- Execute method definitions and calls
- Evaluate expressions
- Control program flow (if conditions, loops)
- Handle return statements
- Raise runtime errors for invalid operations

---

### 4. **Translation** (`Translation.rb`)
Provides additional transformation capabilities for code optimization or intermediate representation.

---

## Supported Features

✅ **Variables & Assignment**
```ruby
x = 10
name = "Alex"
```

✅ **Operators**
- Arithmetic: `+`, `-`, `*`, `/`, `%`
- Logical: `&&`, `||`, `!`
- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`

✅ **Control Flow**
```ruby
if condition
  # code
elsif other_condition
  # code
else
  # code
end

while condition
  # loop body
end

for i in 1..10
  # loop body
end
```

✅ **Methods/Functions**
```ruby
def greet(name)
  return "Hello, " + name
end

greet("Alex")
```

✅ **Data Types**
- Integers: `42`
- Strings: `"hello"`
- Symbols: `:symbol`
- Booleans: `true`, `false`

✅ **Comments**
```ruby
# Single-line comment
```

---

## Quick Start

### Prerequisites
- Ruby 2.7+ installed on your system

### Running the Compiler

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Alex-Ng10/ruby-compiler.git
   cd ruby-compiler
   ```

2. **Execute Ruby code:**
   ```bash
   ruby Interface.rb
   ```

3. **Run test cases:**
   ```bash
   ruby test.rb
   # or check test cases.txt for expected inputs/outputs
   ```

---

## Example Workflow

### Input Code:
```ruby
x = 10
if x > 5
  puts "x is greater than 5"
end
```

### Stage 1 - Tokenization:
```
[IDENTIFIER(x), ASSIGN, NUMBER(10),
 IF, IDENTIFIER(x), GT, NUMBER(5),
 IDENTIFIER(puts), STRING("x is greater than 5"),
 END]
```

### Stage 2 - Parsing:
```
Program
├── AssignmentNode (x = 10)
└── IfNode
    ├── Condition: BinaryOpNode (x > 5)
    └── Body: MethodCallNode (puts "x is greater than 5")
```

### Stage 3 - Evaluation:
```
Output: x is greater than 5
```

---

## File Structure

```
.
├── Tokenization.rb      # Lexical analysis
├── Tokens.rb            # Token definitions
├── Parsing.rb           # Syntax analysis
├── Nodes.rb             # AST node definitions
├── Evaluation.rb        # Interpretation/execution
├── Translation.rb       # Code transformation
├── Interface.rb         # User interface / REPL
├── test.rb              # Test suite
├── test cases.txt       # Test case documentation
└── grammer/             # Grammar specifications
```

---

## Testing

The project includes comprehensive test cases covering:
- Variable assignments and scoping
- Arithmetic and logical operations
- Conditional statements (if/else)
- Loops (while, for)
- Method definitions and calls
- Return statements and control flow

**Run tests:**
```bash
ruby test.rb
```

---

## Team & Contributors

This project was developed collaboratively to improve team working skills and deepen understanding of Ruby and compiler design.

---

## License

[Your License Here]
