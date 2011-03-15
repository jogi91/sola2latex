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

       parameter.each_index { |index|
          parameterwerte[index] = ask("#{parameter[index]}?")
          para parameterwerte[index]
       }
    } 
    @knopf.style(:width => 100, :center => true)
  end
 
    
end