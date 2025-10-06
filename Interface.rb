require 'curses'

Curses::init_screen
Curses::getch

class Screen
    def initialize
    Curses::init_screen
  end

  def render
    # ...
    Curses::getch
  end
end

screen = Screen.new
screen.render