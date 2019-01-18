class Window_Selectable < Window

	def initialize(x, y, w, h, options = {})
		@index = 0;
		@choices_list = []
		super(x, y, w, h, options)
		@content.keypad=true
	end
	
	def max_col
		return 1
	end
	
	def choice_size
		return [@content.maxx/max_col, 1]
	end
	
	def add_choice(choice)
		@choices_list.push(choice)
	end
	
	def choice_count
		@choices_list.count
	end

	def press_right
		move_cursor(1)
	end
	
	def press_left
		move_cursor(-1)
	end
	
	def press_up
		move_cursor(-max_col)
	end
	
	def press_down
		move_cursor(max_col)
	end
	
	def press_ok
		return true
	end
	
	def move_cursor(nb)
		@index += nb
		if @index > choice_count-1 || @index < 0
			@index = @index%choice_count
		end
		draw_choices
	end	
	
	def draw_choices
		clear
		@choices_list.each_with_index do |value, index|
			add = ""
			if index == @index
				@content.color_set(2)
				add_text( "► " + value + " ░▒▓")
				@content.color_set(1)
			else
				add_text("  " + value)
			end
			
			move_cursor_y(1);
		end
	end
	
		
	def wait_for_input
		while com = @content.getch
			case com
				when Curses::KEY_LEFT
					press_left
				when Curses::KEY_RIGHT
					press_right
				when Curses::KEY_UP
					press_up
				when Curses::KEY_DOWN
					press_down
				when 10
					break if press_ok
			end
		end
		return @index
	end

end