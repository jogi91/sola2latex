#Soll durch * definierte listen durch entsprechende LaTeX-Kommandos ersetzen
#module Listparser
	beispielstring ="asdfsadfsadf\nasdf\nasdf\n\n* Ein Punkt\n* Noch ein Punkt\n\nasdf\nasdf\nasdf\nein Text ohne * Liste\n" 

	def parse string
		result = String.new
		string.gsub!(/^\* /, "\\item ") #* am Anfang einer Zeile, gefolgt vom LEerzeichen wird durch den LaTeXbefehl \item ersetzt
		lines = string.split "\n"
		mode = :nolist
		lines.each { |line| 
			words = line.split
			if mode == :nolist
				if words[0] == "\\item"
					words = ["\\begin{compactitem}\n"] + words
					mode = :list
				end
				result += words.join(" ") + "\n"
				next
			else
				if words[0] == "\\item"
					result += words.join(" ") + "\n"
					next
				else
					words = words + ["\n\\end{compactitem}"]
					result += words.join(" ") + "\n"
					mode = :nolist
				end
			end
		}

		return result
	end

	puts parse beispielstring
#end
