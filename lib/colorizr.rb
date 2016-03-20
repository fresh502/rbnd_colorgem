class String
	@@colors_n_code = {red: '31', green: '32', yellow: '33', blue: '34', pink: '95', light_blue: '94', white: '97', light_grey: '37',
		black: '30'}
	def self.create_colors
		@@colors_n_code.each  do |color, code|
			string_for_method = %Q{def #{color.to_s}() "\e[#{code}m\#{self}\e[0m" end}
			class_eval(string_for_method)
		end
	end
	def self.colors
		@@colors_n_code.keys
	end
	def self.sample_colors
		@@colors_n_code.keys.each do |color|
			puts "This is #{color.to_s}".send(color)
		end
	end
	def method_missing(color)
		if @@colors_n_code.keys.include? color
			#string_for_method = %Q{def #{color.to_s}() "\e[#{@@colors_n_code[:color]}m\#{self}\e[0m" end}
			#String.class_eval(string_for_method)
			String.create_colors
			send(color)
		else
			super
		end
	end
end

String.sample_colors
