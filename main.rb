Shoes.app(:title => "Solablock2LaTeX", :width => 800, :height => 800, :resizable => true) do
  #Warnhinweis 
  @hinweis = stack(:width => 800, :height => 800) do
    banner "Warnhinweis", :align => "center"
    para "Dieses Programm wird so wie es ist, ohne jegliche Garantien von mir zur Verfügung gestellt. Es kann frei benutzt und weitergegeben werden."
    @knopf = button("OK"){
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
       @hinweis.remove #Wenn die Daten Eingegeben wurden, Soll der Warnhinweis verschwinden
     }
     title "Blockdaten:"
    @knopf.style(:width => 100, :center => true)
    @knopf.displace(350, 0)
    para "test"
  end
  
  #@status = stack() # Hier sollten die Werte rein, die im Eingabefeld eingegeben worden sind.
  
    
end