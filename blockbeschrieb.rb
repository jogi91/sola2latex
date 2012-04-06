#Stellt die Methoden für einen Blockbeschrieb zur Verfügung
module Blockbeschrieb
	require "listparser"
	include Listparser

	#"Multiline-gets"
	def getLongText
		puts "Es folgt eine lange Texteingabeumgebung."
		puts "Am besten einfach den fertigen Text hineinkopieren, und dann CTRL und D drücken"

		text = `cat`

		return text
	end

	#Da die Latex-Vorlage als langer Text realisiert ist, müssen Zeilenumbrüche durch neue Zellen ersetzt werden.
	def cellfy string
		string = string.gsub("\n\n", "& DOUBLEBACKSLASH \n\n")
		p string
		puts string
		return string
	end

	#Kurze Bedienungsanleitung
	def displayDisclaimer
		puts "\n\nEs folgt der Blockbeschrieb. Es gelten folgende Punkte:"
		puts "- Absätze bitte mit zwei Zeilenumbrüchen trennen"
		puts "- Einfache Listen werden mit * am Anfang der Zeile, gefolgt von einem Leerzeichen erzeugt"
		puts "- Am einfachsten wird der Text einfach hier hineinkopiert (im Terminal geht das mit CTRL-SHIFT-V)"
		puts "- CTRL-D drücken, wenn man fertig ist\n\n"
	end

	def getsBeschrieb what
		puts "Bitte " + what + " eingeben.\n\n----"
		beschrieb = getLongText
		beschrieb = parse beschrieb
		beschrieb = cellfy beschrieb
		return beschrieb
	end

end
