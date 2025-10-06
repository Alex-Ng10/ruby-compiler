require 'curses'
require_relative 'Tokenization'
require_relative 'Parsing'
require_relative 'Nodes'
require_relative 'Evaluation'
require_relative 'Translation'

# Curses::init_screen
# Curses::getch

class Interface
  def initialize(mystery_file)
    @mystery_file = mystery_file
    @parameters = []
    @expected_values = []
    @actual_values = []
    @user_code = ""
    @output_text = ""
    @error_text = ""
    @runtime = Runtime.new

    load_mystery_function
    setup_windows
  end

  def load_mystery_function
    lines = Files.readlines(@mystery_file).map(&:strip)

    # the first line contains parameter types
    param_line = lines[0]
    @param_types = param_line.split

    # this should parse the reference implementation to undersatnd the function
    reference_code = lines[1..-1].join("\n")

    @param_names = ('a'..'z').first(@param_types.length)
  end

  def setup_windows
    init_screen
    noecho
    curse_set(0)

    height = lines
    width = cols

    @param_input_window = Window.new(5, width / 2, 0, 0)
    @table_window = Window.new(height - 15, width / 2, 5, 0)
    @code_window = Window.new(10, width / 2, 0, width / 2)
    @output_window = Window.new(height - 10, width / 2, 10, width / 2)

    [@param_input_window, @table_window, @code_window, @output_window].each do |win|
      win.keypad(true)
    end
    if has_colors?
      start_color
      init_pair(1, COLOR_WHITE, COLOR_BLUE)
      init_pair(2, COLOR_BLACK, COLOR_WHITE)
      init_pair(3, COLOR_RED, COLOR_BLACK)
    end
  end

  def draw_interface
    clear # Clear the screen

    draw_param_input 
    draw_table 
    draw_code_editor 
    draw_output 
    draw_instructions 

    refresh # Refresh the screen to show updates
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
    inp.addstr("Press ENTER to add test case")
    inp.refresh
  end

  def draw_table
    table = @table_window

    table.clear
    table.box(0, 0)
    table.setpos(0, 2)
    table.addstr("Test Cases")

    #Header row
    table.setpos(1, 1)
    header = @param_names.join(" | ") + " | Expected | Actual"
    table.addstr(header)

    # Draw horizontal line
    table.setpos(2, 1)
    table.addstr("-" * (header.length))

    # Draw data rows
    @parameters.each_with_index do |params_set, index|
      table.setpos(index + 3, 1)
      row = param_set.join (" | ")
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
    code.addstr("Code Editor")

    lines = @user_code.lines
    lines.each_with_index do |line, index|
      next if index >= 8 # Leave space for box borders
      code.setpos(index + 1, 1)
      code.addstr(line.chomp[0, @code.maxx - 2])
    end

    code.refresh

    def draw_output
      output = @output_window
      output.clear
      output.box(0, 0)
      output.setpos(0, 2)
      output.addstr("Output")

      if @error_text.length > 0
        output.attron(color_pair(3)) if has_colors? # Red text for errors
        output.setpos(1, 1)
        output.addstr("Error: #{@error_text}")
        output.attroff(color_pair(3)) if has_colors?
      else
        output.setpos(1, 1)
        output.addstr(@output_text)
      end
      output.refresh
    end

    def draw_instructions
      setpos(lines - 2, 0)
      addstr("Controls: F1=Add Test Case | F2=Run Code | F3=Clear Code | F4=Exit")
      refresh
    end

    def get_parameter_input
      values = []

      param = @param_input_window
      @param_types.each_with_index do |type, index|
        # Move cursor to input position for this parameter
        param.setpos(index + 1, @param_names[index].length + @param_types[index].length + 6)

        # Enable echoing so user input is visible
        echo

        # Show the cursor for input
        curs_set(1)

        input = ""
        loop do
          c = @param_input_window.getch
          if c == 10
            break
          elsif c == 127 || c == KEY_BACKSPACE
            if inp.length > 0
              inp.chop!
              inp.setpos(index + 1, @param_names[index].length + @param_types[index].length + 6)
              inp.addstr(inp + " ")
              inp.setpos(index + 1, @param_names[index].length + @param_types[index].length + 6 + inp.length)
            end
          else
            input += c.chr
            param.addch(c)
          end
        end

        case type
        when "int"
          values << input.to_i
        when "float"
          values << input.to_f
        when "string"
          values << input
        else
          values << (input.downcase == "true" || input == "1")
        end

        noecho
        curs_set(0)
      end

      values
  end

  def edit_code
    code = @code_window
    code.box(0, 0)
    code.setpos(0, 2)
    code.addstr("Code Editor (ESC to finish)")
    code.refresh
    
    noecho
    curs_set(1)

    text = @user_code
    cursor_row = 1
    cursor_col = 1

    loop do
      # Display current text
      code.clear
      code.box(0, 0)
      code.setpos(0, 2)
      code.addstr("Code Editor (ESC to finish)")

      text.lines.each_with_index do |line, index|
        break if index >= 8
        code.setpos(index + 1, 1)
        code.addstr(line.chomp[0, code.maxx - 2])
      end

      code.setpos(cursor_row, cursor_col)
      code.refresh

      c = code.getch

      if c == 27 # ESC key
        break
      elsif c == 10 # Enter key
        text += "\n"
        cursor_row += 1
        cursor_col = 1
      elseif c == 127 || c == KEY_BACKSPACE
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
        text += c.chr
        cursor_col += 1
      end
      
      def run_code
        @error_text = ""
        @output_text = ""
        @actual_values.clear

        begin
          @parameters.each_with_index do |param_set, test_index| 
            test_runtime = Runtime.new 
            @param_names.each_with_index do |name, index|
              case @param_types[index]
              when "int"
                test_runtime.variables[name] = IntegerPrimitive.new(param_set[index])
              when "float"
                test_runtime.variables[name] = FloatPrimitive.new(param_set[index])
              when "string"
                test_runtime.variables[name] = StringPrimitive.new(param_set[index])
              when "bool"
                test_runtime.variables[name] = BoolPrimitive.new(param_set[index])
              end
            end

            @output_text = "Code executed successfully."

          rescue => e
            @error_text = e.message
          end
        end

        def calculated_expected_values
          @expected_values.clear
          @parameters.each do |param_set|
            
            case File.basename(@mystery_file)
            when "mystery1.txt"
              sum = param_set[0] + param_set[1]
              @expected_values << sum / 2
            when "mystery2.txt"
              phrase = param_set[0] + param_set[1] + param_set[2]
              @expected_values << phrase + "!?"
            when "mystery3.txt"
              sum = param_set[0] + param_set[1]
              @expected_values << sum / 2.0
            when "mystery4.txt"
              @expected_values << (param_set[0] && param_set[1])
            when "mystery5.txt"
              result parma_set[1] == param_set[2]
              @expected_values << (result && param_set[0])
            else
              @expected_values << "Unknown"
            end
        end
      end
# class Screen
#     def initialize
#     Curses::init_screen
#     end

#   def render
#     # ...
#     Curses::getch
#   end
# end

# screen = Screen.new
# screen.render
