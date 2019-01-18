
class Screen

end

class Screen_Title

	def initialize
		title = Window_Title.new
		win = Window_TitleMenu.new
		c = win.wait_for_input
		title.close
		win.close
	end

end

class Screen_Talk

	def initialize
		message = Window_Message.new
		name = Window_Name.new
		message.set_text("Hey ! bienvenue !", x:"center", y:"center")
		name.set_text("Hinola")
		c = message.wait_for_input
		puts c
	end

end