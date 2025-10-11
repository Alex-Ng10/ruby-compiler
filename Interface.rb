require 'curses'
require 'stringio'
require_relative 'Tokenization'
require_relative 'Parsing'
require_relative 'Nodes'
require_relative 'Evaluation'
require_relative 'Translation'

include Curses

class Interface
  def initialize(mystery_file)
    @mystery_file = mystery_file
    @parameters = []        # [[vals per row], ...]
    @expected_values = []   # ["", ...]
    @actual_values = []     # ["", ...]
    @user_code = ""         # code in your DSL
    @output_text = ""       # captured printed output
    @error_text = ""        # last error
    @runtime = Runtime.new

    load_mystery_function
    setup_windows
  end

  def load_mystery_function
    lines = File.readlines(@mystery_file).map(&:strip)  # File, not Files
    # first line = parameter types
    @param_types = lines[0].split
    # reference code stays hidden; we compute expected values in Ruby below
    # reference_code = lines[1..-1].join("\n")
    @param_names = ('a'..'z').first(@param_types.length)  # a, b, c, ...
  end

  def setup_windows
    init_screen
    noecho
    curs_set(0)   # was curse_set

    height = lines
    width = cols

    @param_input_window = Window.new(5, width / 2, 0, 0)
    @table_window       = Window.new(height - 15, width / 2, 5, 0)
    @code_window        = Window.new(10, width / 2, 0, width / 2)
    @output_window      = Window.new(height - 10, width / 2, 10, width / 2)

    [@param_input_window, @table_window, @code_window, @output_window].each { |win| win.keypad(true) }

    if has_colors?
      start_color
      init_pair(1, COLOR_WHITE, COLOR_BLUE)
      init_pair(2, COLOR_BLACK, COLOR_WHITE)
      init_pair(3, COLOR_RED, COLOR_BLACK)
    end
  end

  def draw_interface
    clear
    draw_param_input
    draw_table
    draw_code_editor
    draw_output
    draw_instructions
    refresh
  end

  def draw_param_input
    inp = @param_input_window
    inp.clear
    inp.box(0, 0)
    inp.setpos(0, 2)
    inp.addstr(" Parameter Input ")

    @param_names.each_with_index do |name, index|
      inp.setpos(index + 1, 1)
      inp.addstr("#{name} (#{@param_types[index]}): ")
    end
    inp.setpos(@param_names.length + 2, 1)
    inp.addstr("Press F1 to add test case")
    inp.refresh
  end

  def draw_table
    table = @table_window
    table.clear
    table.box(0, 0)
    table.setpos(0, 2)
    table.addstr("Test Cases")

    # header row
    table.setpos(1, 1)
    header = @param_names.join(" | ") + " | Expected | Actual"
    table.addstr(header)

    # horizontal line
    table.setpos(2, 1)
    table.addstr("-" * header.length)

    # data rows
    @parameters.each_with_index do |params_set, index|
      table.setpos(index + 3, 1)
      row = params_set.map(&:to_s).join(" | ")
      row += " | #{@expected_values[index] || 'N/A'}"
      row += " | #{@actual_values[index] || 'N/A'}"
      table.addstr(row)
    end
    table.refresh
  end

  def draw_code_editor
    code = @code_window
    code.clear
    code.box(0, 0)
    code.setpos(0, 2)
    code.addstr("Code Editor (F2 to edit/run)")
    w = code.maxx - 2

    @user_code.lines.each_with_index do |line, index|
      break if index >= 8
      code.setpos(index + 1, 1)
      code.addstr(line.chomp[0, w])
    end

    code.refresh
  end

  def draw_output
    output = @output_window
    output.clear
    output.box(0, 0)
    output.setpos(0, 2)
    output.addstr("Output")

    if @error_text && @error_text.length > 0
      output.attron(color_pair(3)) if has_colors?
      output.setpos(1, 1)
      output.addstr("Error: #{@error_text}")
      output.attroff(color_pair(3)) if has_colors?
    else
      output.setpos(1, 1)
      out_lines = @output_text.to_s.split("\n")
      out_lines.first(@output_window.maxy - 2).each_with_index do |l, i|
        output.setpos(1 + i, 1)
        output.addstr(l[0, @output_window.maxx - 2])
      end
    end
    output.refresh
  end

  def draw_instructions
    setpos(lines - 2, 0)
    addstr("Controls: F1=Add Test Case | F2=Edit+Run | F3=Clear Code | F4/q=Exit")
    refresh
  end

  def get_parameter_input
    values = []
    param = @param_input_window

    @param_types.each_with_index do |type, index|
      # move cursor to input position for this parameter
      x = @param_names[index].length + @param_types[index].length + 6
      param.setpos(index + 1, x)
      echo
      curs_set(1)

      input = ""
      loop do
        c = param.getch
        if c == 10 # Enter
          break
        elsif c == 127 || c == KEY_BACKSPACE || c == 263
          next if input.empty?
          input.chop!
          y, _ = param.cury, param.curx
          param.setpos(index + 1, x)
          param.addstr(" " * (@output_window.maxx - x - 1))
          param.setpos(index + 1, x)
          param.addstr(input)
        else
          ch = c.is_a?(Integer) ? c.chr : c.to_s
          input << ch
          param.addstr(ch)
        end
      end

      case type
      when "int"    then values << input.to_i
      when "float"  then values << input.to_f
      when "string" then values << input
      when "bool"   then values << (%w[true 1 t].include?(input.strip.downcase))
      else               values << input
      end

      noecho
      curs_set(0)
    end

    values
  end

  def edit_code
    code = @code_window
    noecho
    curs_set(1)

    text = @user_code.dup
    cursor_row = 1
    cursor_col = 1

    loop do
      # draw
      code.clear
      code.box(0, 0)
      code.setpos(0, 2)
      code.addstr("Code Editor (ESC to finish)")
      w = code.maxx - 2

      text.lines.each_with_index do |line, index|
        break if index >= 8
        code.setpos(index + 1, 1)
        code.addstr(line.chomp[0, w])
      end

      code.setpos(cursor_row, cursor_col)
      code.refresh

      c = code.getch
      if c == 27 # ESC
        break
      elsif c == 10 # Enter
        text << "\n"
        cursor_row += 1
        cursor_col = 1
      elsif c == 127 || c == KEY_BACKSPACE || c == 263
        if text.length > 0
          text.chop!
          if cursor_col > 1
            cursor_col -= 1
          elsif cursor_row > 1
            cursor_row -= 1
            cursor_col = 1
          end
        end
      else
        ch = c.is_a?(Integer) ? c.chr : c.to_s
        text << ch
        cursor_col += 1
      end
    end

    curs_set(0)
    text
  end

  def run_code
    @error_text = ""
    @output_text = ""
    @actual_values = Array.new(@parameters.length)

    begin
      @parameters.each_with_index do |param_set, test_index|
        test_runtime = Runtime.new

        # bind a,b,c,... in this test's runtime
        @param_names.each_with_index do |name, idx|
          case @param_types[idx]
          when "int"
            test_runtime.variables[name] = IntegerPrimitive.new(param_set[idx])
          when "float"
            test_runtime.variables[name] = FloatPrimitive.new(param_set[idx])
          when "string"
            test_runtime.variables[name] = StringPrimitive.new(param_set[idx])
          when "bool"
            test_runtime.variables[name] = BooleanPrimitive.new(param_set[idx])
          else
            test_runtime.variables[name] = StringPrimitive.new(param_set[idx].to_s)
          end
        end

        # parse + eval user's code
        lexer = Lexer.new(@user_code)
        ast = Parser.new(lexer.tokens).parse

        # capture prints
        old_stdout = $stdout
        sio = StringIO.new
        $stdout = sio
        result = ast.visit(Evaluator.new(test_runtime))
        $stdout = old_stdout

        printed = sio.string
        @output_text << printed unless printed.empty?

        actual = result.respond_to?(:value) ? result.value : result
        @actual_values[test_index] = actual
      end
    rescue => e
      @error_text = e.message
    end
  end

  def calculate_expected_values
    @expected_values.clear
    @parameters.each do |param_set|
      case File.basename(@mystery_file)
      when "mystery1.txt" # int int ; (a + b) / 2
        sum = param_set[0].to_i + param_set[1].to_i
        @expected_values << (sum / 2)
      when "mystery2.txt" # string string string ; (a + b + c) + "!?"
        phrase = param_set[0].to_s + param_set[1].to_s + param_set[2].to_s
        @expected_values << (phrase + "!?")
      when "mystery3.txt" # float float ; (a + b) / 2.0
        sum = param_set[0].to_f + param_set[1].to_f
        @expected_values << (sum / 2.0)
      when "mystery4.txt" # int int ; a * b
        @expected_values << (param_set[0].to_i * param_set[1].to_i)
      when "mystery5.txt" # bool int int ; (b == c) && a
        result = (param_set[1].to_i == param_set[2].to_i)
        @expected_values << (result && !!param_set[0])
      else
        @expected_values << "Unknown"
      end
    end
  end

  def start
    stdscr.keypad(true)
    draw_interface
    loop do
      ch = stdscr.getch
      case ch
      when KEY_F1
        vals = get_parameter_input
        @parameters << vals
        calculate_expected_values
        draw_interface
      when KEY_F2
        @user_code = edit_code
        run_code
        draw_interface
      when KEY_F3
        @user_code = ""
        @actual_values.clear
        @output_text = ""
        @error_text = ""
        draw_interface
      when KEY_F4, 'q'.ord
        break
      end
    end
  ensure
    close_screen
  end
end

# CLI entry
if __FILE__ == $0
  path = ARGV[0]
  unless path && File.exist?(path)
    puts "Usage: ruby Interface.rb grammer/mystery1.txt"
    exit 1
  end
  Interface.new(path).start
end
