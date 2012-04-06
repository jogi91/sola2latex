module Basisdaten
	#Returns an Array with Keys in CAPITALS (as in the template) and each key is followed by it's value
	def basisdatenabfrage
		basisdaten = Array.new
		puts "Was ist der Blockname?"
		basisdaten.push gets.chomp
		basisdaten.push "BLOCKNAME"

		puts "Was ist die J+S-Nummer (LA/LS Nummer des Tages.Blocknummer)?\nBeispiel: LA 3.2 bezeichnet die 2. Lageraktivität am 3. Tag"
		blocknummer = gets.chomp
		basisdaten.push blocknummer
		basisdaten.push "J+S-NUMMER"

		puts "Wer leitet den Block?"
		basisdaten.push gets.chomp
		basisdaten.push "LEITUNG"

		puts "Teilnehmer?"
		basisdaten.push gets.chomp
		basisdaten.push "TEILNEHMER"

		puts "Wo findet der Block statt?"
		basisdaten.push gets.chomp
		basisdaten.push "ORT"

		puts "Was ist das Blockdatum?"
		basisdaten.push gets.chomp
		basisdaten.push "DATUM"

		puts "Von wann bis wann findet der Block statt?"
		basisdaten.push gets.chomp
		basisdaten.push "ZEIT"

		puts "Welches Material wird gebraucht (Durch Kommas getrennt angeben)?"
		basisdaten.push gets.chomp
		basisdaten.push "MATERIAL"

		return basisdaten, blocknummer
	end

	#Fragt den Anwender nach zielen.
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

	#Sicherheitskonzept
	def sikoabfrage
		input = String.new
		siko = String.new
		puts "Es folgt die Eingabe des Sicherheitskonzepts, welches als Liste dargestellt wird"
		puts "Als absolutes Minimum ist ein Verweis auf das Lagersicherheitskonzept nötig"
		while input != "END"
			unless input.empty?
				siko += "\\item " + input +"\n\t\t"
			end
			puts "Bitte einen SikoPunkt eingeben, oder END, wenn alles eingegeben wurde"
			input = gets.chomp
		end

		return siko
	end

	def fillTemplate template
		basisdaten, blocknummer = basisdatenabfrage
		ziele = zielabfrage
		siko = sikoabfrage
		(basisdaten.length/2).times do
			key = basisdaten.pop
			value = basisdaten.pop
			template.gsub!(key, value)
		end
		template.gsub!(/ZIELE/, ziele)
		template.gsub!(/SICHERHEITSKONZEPT/, siko)

		return template, blocknummer
	end
end
