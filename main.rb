require "Kopierer"
$a = Shoes.app(:title => "Solablock2LaTeX", :width => 800, :height => 800, :resizable => true) do
  datenhandler = Kopierer.new
  #Hauptflow, hier kommt alles rein
  flow(:scroll => false, :width => 800, :height => 800) do



    #Warnhinweis 
    @hinweis = stack(:width => 800, :height => 800) do
      debug @editor.inspect
      banner "Warnhinweis", :align => "center"
      para "Dieses Programm wird so wie es ist, ohne jegliche Garantien von mir zur Verfügung gestellt. Es kann frei benutzt und weitergegeben werden."
      @knopf = button("OK"){
        #Wenn der Knopf gedrückt wird, erste Werte einlesen
        # Werte für die Grundlegenden Blockdaten abfragen
        parameter = ["Blockname", "J+S-Nummer", "Leitung", "Teilnehmer", "Ort", "Datum", "Zeit"]
        datenhandler.basisparameter = parameter
        parameterwerte = Array.new(parameter.size){String.new}
        debug parameterwerte.inspect
        parameter.each_index{|index|
          debug index.inspect
          parameterwerte[index] = ask("#{parameter[index]}?")
          @hinweis.append do #Anderenfalls würden die paragraphs ausserhalb von @hinweis platziert werden.
            para "#{parameter[index]}: #{parameterwerte[index]}"
          end
        }
        datenhandler.basisparameterwerte = parameterwerte #Die Parameterwerte werden in den Kopierer geladen

        # 
        # #Ziele abfragen
        # ziele = Array.new
        # counter = 1
        # while true
        #  ziel = ask("Blockziel #{counter}, leerlassen für Ende")
        #  counter += 1
        #  if ziel == "" or ziel == nil
        #    break
        #  end
        #  ziele.push ziel
        # end
        # datenhandler.ziele = ziele
        # 
        # #Sicherheitskonzept abfragen
        #  alert("Nun wird das Sicherheitskonzept abgefragt. Jeder Punkt wird im Blockbeschrieb ein Teil einer Liste werden. Bitte entsprechend formulieren.")
        #  sicherheiten = Array.new
        #  counter = 1
        #  while true
        #   sicherheit = ask("Punkt Nr. #{counter}, leerlassen für Ende")
        #   counter += 1
        #   if sicherheit == "" or sicherheit == nil
        #     break
        #   end
        #   sicherheiten.push sicherheit
        #  end
        #  datenhandler.sicherheit = sicherheiten
        debug "self vor dem removen"
        debug self.inspect
        @hinweis.remove #Wenn die Daten Eingegeben wurden, Soll der Warnhinweis verschwinden
        @zielestack.show
      }
      title "Blockdaten:"
      @knopf.style(:width => 100, :center => true)
      @knopf.displace(350, 0)
      para "test"
    end
    #Hinweis fertig
    
    #Ziele-Fenster
    @zielestack = stack(:title => "Blockziele", :height => 800, :width => 800) do
      ziele = Array.new
      stack(:width => 800, :margin_left => 40, :margin_right => 40) do
        title "Blockziele"
        para "Hier werden die Ziele eingegeben. Bitte immer nur ein Ziel in die Textbox kopieren und den hinzufügen-Button drücken. Wenn man das letzte Ziel eingegeben hat, kann der Vorgang durch klicken auf Fertig abgeschlossen werden."
        ziel = edit_box(:width => 1.0)
        keypress do |k|
          debug ziel.inspect
          if k == :alt_v
            ziel.text += self.clipboard
          end
        end
        flow do
          button("hinzufügen"){
            ziele.push ziel.text
            ziel.text = ""
          }
          i = button("Fertig"){
            debug ziele.inspect
            datenhandler.ziele = ziele
            @zielestack.remove
          }
        end
      end
    end
    #zielefenster fertig
    
    #Sicherheitskonzept-Fenster
    @sicherheitskonzeptstack = stack(:title => "Blockziele", :height => 800, :width => 800) do
      sicherheiten = Array.new
      stack(:width => 800, :margin_left => 40, :margin_right => 40) do
        title "Sicherheitskonzept"
        para "Hier wird das Sicherheitskonzept eingegeben, etc. blabla."
        sicherheit = edit_box(:width => 1.0)
        keypress do |k|
          if k == :alt_v
            sicherheit.text += self.clipboard
          end
        end
        flow do
          button("hinzufügen"){
            sicherheiten.push sicherheit.text
            sicherheit.text = ""
          }
          i = button("Fertig"){
            debug sicherheiten.inspect
            datenhandler.sicherheit = sicherheiten
            @sicherheitskonzeptstack.remove
          }
        end
      end
    end
    
    #editor, wird am Anfang noch nicht angezeigt
    @editor = stack(:width => 800, :height => 800) do
      banner "Editor", :align => "center"
      flow{
        button("Zeige Blockinfos"){}
        button("Speichern"){}
      }
    end


    #@status = stack() # Hier sollten die Werte rein, die im Eingabefeld eingegeben worden sind.

  end
end