require 'curses'

Curses.init_screen
Curses.addstr('press a key')
Curses.getch
Curses.close_screen