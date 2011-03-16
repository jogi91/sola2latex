Shoes.app(:title => "Solablock2LaTeX", :width => 800, :height => 800, :resizable => true) do
  #Warnhinweis 
  @hinweis = stack(:width => 790, :height => 790) do
    background red
    @knopf = button("ok"){
      #Wenn der Knopf gedrückt wird, erste Werte einlesen
      # Werte für die Blockdaten abfragen
       parameter = ["Blockname", "J+S-Nummer", "Leitung", "Teilnehmer", "Ort", "Datum", "Zeit"]
       parameterwerte = Array.new(parameter.size){String.new}
       debug parameterwerte.inspect
       parameter.each_index{|index|
       	debug index.inspect
       	parameterwerte[index] = ask("#{parameter[index]}?")
       	@hinweis.append do #Anderenfalls würden die paragraphs ausserhalb von @hinweis platziert werden.
       	  para "#{parameter[index]}: #{parameterwerte[index]}"
     	  end
       }
       debug @daten.inspect
     }
     title "Blockdaten:"
    
     
    @knopf.style(:width => 100, :center => true)
    para "test"
  end
 
    
end