Shoes.app do
  # Werte für die Blockdaten abfragen
  parameter = ["Blockname", "J+S-Nummer", "Leitung", "Teilnehmer", "Ort", "Datum", "Zeit"]
  parameterwerte = Array.new(parameter.size){String.new}
  debug parameterwerte.inspect
  
  parameter.each_index { |index|
     parameterwerte[index] = ask("#{parameter[index]}?")
  }
  
  debug parameterwerte.inspect
    
end