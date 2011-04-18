module Textmanipulator
  def escape_latex(string)
    string.gsub!(/\\/,"\\textbackslash") #backslashes werden durch einen Backslash im fliesstext ersetzt
    string.gsub!(/\$/,"\\$")
    string.gsub!(/_/,"\\_")
    string.gsub!(/\[/,"$\\lbrack$")
    string.gsub!(/\]/,"$\\rbrack$")
    string.gsub!(/</,"\\textless")
    string.gsub!(/>/,"\\textgreater")
    string.gsub!(/\302\247/,"\\S") #Das §-Zeichen
    string.gsub!(/&/, "AMPERSAND") #Das & Zeichen nimmt z. T. noch einen wert an, je nachdem wie es escaped ist, gsub(/MATCHIRGENDWAS/, "\\&") gibt nicht \& im puts sondern MATCHIRGENDWAS. Die Escapes werden irgendwie aufgefressen.
    string.gsub!(/#/,"\\#")
    string.gsub!(/\{/,"\\{")
    string.gsub!(/\}/,"\\}")
    string.gsub!(/%/,"\\%")
    string.gsub!(/~/,"\\textasciitilde")
    string.gsub!(/"/,"\"\'") #Das Anführungszeichen wird durch ein Anführungszeichen und einen Apostroph ersetzt
    string.gsub!(/\342\202\254/,"\\texteuro") #Das Eurozeichen
    debug string.inspect
    return string
  end
  
  #soll den Text und die Kommentare ordentlich in Zwei Spalten Aufteilen, und dabei Listen u. ä. berücksichtigen
  def balance_comments(text, kommentar)
    clean_text = escape_latex(text)
    clean_kommentar = escape_latex(kommentar)

    #lange Kommentare sollen gesplittet werden.
    kommentarteile_unbearbeitet = clean_kommentar.lines.to_a
    kommentarteile = Array.new
    kommentarzellen = 0
    for counter in 0..kommentarteile_unbearbeitet.length
      kommentarteile.push(kommentarteile_unbearbeitet[counter])
      #Alle 10 Zeilen  und am Ende eine neue Tabellenzelle Anfangen
      if counter % 10 == 0 or counter == kommentarteile_unbearbeitet.length
        kommentarteile.push("\\\\\\ \n\n") #Doublebackslash
      end
    end
    
    #text splitten
    text_unbearbetet = clean_text.lines.to_a
    textteile = Array.new
    for counter in 0..text_unbearbetet.length
      textteile.push(text_unbearbetet[counter])
      if counter % 10 == 0 or counter == text_unbearbetet.length
        #Alle 10 Zeilen Zelle abschliessen
        textteile.push(" & ")
        #Wenn es keine Kommentare mehr anzufügen gibt, leere kommentarzelle hinzufügen
        if kommentarteile.length == 0
          textteile.push("\\\\\\ \n\n")
        #sonst die ersten 11 elemente vom Kommentararray anfügen und löschen
        else
          textteile.concat(kommentarteile.slice!(0..11))
        end
      end
    end
  end
  
  #Erstellt aus einem String Listen. Vorerst sollen noch keine Unterpunkte unterstützt werden
  def parse_lists(string)
    debug "parse_lists aufgerufen"
    zeilen = Array.new
    geparster_string = String.new
    zeilen = string.lines.to_a #Jede Zeile wird einzeln untersucht
    liste = false
    zeilen.each do |zeile|
      debug zeile.inspect
      if liste == false and zeile.start_with?("*")
        liste = true
        geparster_string = geparster_string + "\\begin{compactitem}\n"
        geparster_string = geparster_string + make_listpoint(zeile)
      elsif liste == true and zeile.start_with?("*")
        geparster_string = geparster_string + make_listpoint(zeile)
      elsif liste == true and not zeile.start_with?("*")
        liste = false
        geparster_string = geparster_string + "\\end{compactitem}\n" + zeile
      else
        geparster_string = geparster_string + zeile
      end
    end
    #wenn die Letzte Zeile noch ein Tabellenpunkt war, wird er jetzt geschlossen
    if liste == true
      geparster_string = geparster_string + "\\end{compactitem}\n"
    end
    
    return geparster_string
  end
  
  #Macht aus einem String einen Listenpunkt
  def make_listpoint(string)
    listenpunkt = "\\item " + string.slice(1..-1).lstrip #LaTeX-Kommando bauen, Stern und Whitespaces am Anfang entfernen
    return listenpunkt
  end
end