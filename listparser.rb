#Soll durch * definierte listen durch entsprechende LaTeX-Kommandos ersetzen
module Listparser
	#Erstellt genau die erwähnten Listen, aber nicht verschachtelt
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
					words = ["\\end{compactitem}\n"] +words 
					result += words.join(" ") + "\n"
					mode = :nolist
				end
			end
		}

		return result
	end

end
