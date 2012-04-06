module Basisdaten
	#Returns an Array with Keys in CAPITALS (as in the template) and each key is followed by it's value
	def basisdatenabfrage
		basisdaten = ["BLOCKNAME"]
		puts "Was ist der Blockname?"
		basisdaten.push gets.chomp

		basisdaten.push "J+S-NUMMER"
		puts "Was ist die J+S-Nummer (LA/LS Nummer des Tages.Blocknummer)?\nBeispiel: LA 3.2 bezeichnet die 2. Lageraktivität am 3. Tag"
		basisdaten.push gets.chomp

		basisdaten.push "LEITUNG"
		puts "Wer leitet den Block?"
		basisdaten.push gets.chomp

		basisdaten.push "TEILNEHMER"
		puts "Teilnehmer?"
		basisdaten.push gets.chomp

		basisdaten.push "ORT"
		puts "Wo findet der Block statt?"
		basisdaten.push gets.chomp

		basisdaten.push "DATUM"
		puts "Was ist das Blockdatum?"
		basisdaten.push gets.chomp

		basisdaten.push "ZEIT"
		puts "Wann findet der Block statt?"
		basisdaten.push gets.chomp

		basisdaten.push "MATERIAL"
		puts "Welches Material wird gebraucht (Durch Kommas getrennt angeben)?"
		basisdaten.push gets.chomp

		return basisdaten
	end

	def zielabfrage
		input = String.new
		ziele = String.new
		while input != "END"
			unless input.empty?
				ziele += "\\item " + input +"\n\t\t"
			end
			puts "Bitte ein Ziel eingeben, oder END, wenn alle Ziele eingegeben wurden"
			input = gets.chomp
		end

		return ziele
	end
end
