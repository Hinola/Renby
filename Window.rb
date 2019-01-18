
class Window
	
	def initialize(x, y, w, h, options = {})
		@win = Curses::Window.new(h, w, y, x)
		@content = Curses::Window.new(h-2*padding[1], w-2*padding[0], y+padding[1], x+padding[0])
		@closed = false
		if options[:ws]
			@windowskin = options[:ws]
		else
			@windowskin = base_windowskin
		end
		@win.color_set(window_color)
		draw_windowskin
		create_origin
		refresh
	end
	
	# box methods
	def padding
		return [1,1]
	end
	
	def base_windowskin
		[	'╔','═','╗',
			'║',' ','║',
			'╚','═','╝']
	end
	
	def window_color
		return 1
	end
	
	def draw_windowskin
		return unless @windowskin
		w = (@win.maxx-2)
		h = (@win.maxy-2)
		@win.setpos(0,0)
		@win.addstr(@windowskin[0] + (@windowskin[1]*w) + @windowskin[2])
		h.times do |y|
			@win.setpos(y+1,0)
			@win.addstr(@windowskin[3] + (@windowskin[4]*w) + @windowskin[5])
		end
		@win.setpos(h+2,0)
		@win.addstr(@windowskin[6] + (@windowskin[7]*w) + @windowskin[8])
	end
	
	def set_windowskin(windowskin)
		@windowskin = windowskin
		redraw
	end
	
	def redraw
		@win.box('|', '-')
		refresh
	end
	
	# Cursor methods
	def create_origin
		@origin = [0,0]
		@pos = @origin
		setpos
	end
	
	def reset_cursor
		@pos = @origin
		setpos
	end
	
	def setpos;					@content.setpos(@pos[1], @pos[0]);	end;	
	def pos_cursor(x,y);		@pos = [x,y];			setpos;		end;
	def pos_cursor_x(x);		@pos = [x, @pos[1]];	setpos;		end;
	def pos_cursor_y(y);		@pos = [@pos[0], y];	setpos;		end;
	def move_cursor_x(x);		@pos[0] += x;			setpos;		end;
	def move_cursor_y(y);		@pos[1] += y;			setpos;		end;
	
	# display methods
	def show
	end
	
	def hide
	end
	
	def close
		@win.clear
		@content.clear
		refresh
		@win.close
		@content.close
		@closed = true
	end
	
	def closed?
		@closed
	end
	
	def refresh
		@win.refresh
		@content.refresh
	end
	
	# content methods
	def clear
		@content.clear
		reset_cursor
	end
	
	def set_text(text, options = {})
		return if closed?
		clear
		add_text(text, options)
	end
	
	def add_text(text, options = {})
		return if closed?
		x = @pos[0]
		y = @pos[1]
		if options[:x]
			case options[:x]
				when "right"
					x = @content.maxx - text.length
				when "center"
					x = (@content.maxx - text.length)/2
			end
		end
		if options[:y]
			case options[:y]
				when "bottom"
					y = @content.maxy-1
				when "center"
					y = @content.maxy/2
			end
		end
		pos_cursor(x,y)
		@content<<text
		refresh
	end
	
	def add_line(text, options = {})
		move_cursor_y(1)
		add_text(text, options)
	end
		
	def wait_for_input
		@content.getch
	end
	
end