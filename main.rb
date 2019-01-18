require 'io/console'
require 'curses'
require_relative 'Window'
require_relative 'Window_Selectable'
require_relative 'windows'
require_relative 'Screen'

$window = IO.console
$window.winsize = [20,50]

Curses.init_screen
Curses.start_color
Curses.noecho
Curses.curs_set(0)
Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
Curses.init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_CYAN)
Curses.init_pair(3, Curses::COLOR_CYAN, Curses::COLOR_BLACK)

#return 
begin
	
	title = Screen_Title.new
	
	dialogue = Screen_Talk.new

ensure
	Curses.close_screen
end