
class Window_Title < Window

	def initialize
		super(1,1,Curses.cols-2,5)
		@content.color_set(3)
		set_text("░▒▓█ LA LEGENDE DU RUBY BLEU █▓▒░", x:"center", y:"center")
	end

	def base_windowskin
		[	' ',' ',' ',
			' ',' ',' ',
			'╬','═','►']
	end
	
	def window_color
		return 3
	end

end

class Window_TitleMenu < Window_Selectable
	
	def initialize
		w =  26
		h = 9
		super( (Curses.cols-w)/2 ,(Curses.lines-h-2) ,w ,h )
		add_choice("Nouvelle partie")
		add_choice("Continuer")
		add_choice("Options")
		add_choice("A propos")
		add_choice("Quitter")
		draw_choices
	end
	
	def padding
		return [2,2]
	end
	
end

class Window_Message < Window

	def initialize
		h = 9
		super(1, Curses.lines-h-1, Curses.cols-2, h)
	end
	
	def padding
		return [2,1]
	end

end

class Window_Name < Window

	def initialize
		w = 20
		h = 3
		super(1, Curses.lines-h-9, w, h)
		@content.color_set(3)
	end
	
	def padding
		return [2,1]
	end
	
	def base_windowskin
		[	'╔','═','╗',
			'║',' ','║',
			'╠','═','╩']
	end

end