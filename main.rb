require "Kopierer"
$a = Shoes.app(:title => "Solablock2LaTeX", :width => 800, :height => 800, :resizable => true) do
  datenhandler = Kopierer.new
  flow(:scroll => false, :width => 800, :height => 800) do

    #editor, wird am Anfang noch nicht angezeigt
    @editor = stack(:width => 800, :height => 800, :hidden => false) do
      banner "Editor", :align => "center"
    end

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

        #Ziele-Fenster
        dialog(:title => "Blockziele", :height => 320) do
          ziele = Array.new
          stack(:margin_left => '10%', :left => '-5%') do
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
                close
              }
            end
          end
        end
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

        debug @daten.inspect
        debug datenhandler.inspect
        @hinweis.remove #Wenn die Daten Eingegeben wurden, Soll der Warnhinweis verschwinden
      }
      title "Blockdaten:"
      @knopf.style(:width => 100, :center => true)
      @knopf.displace(350, 0)
      para "test"
    end
    #Hinweis fertig



    #@status = stack() # Hier sollten die Werte rein, die im Eingabefeld eingegeben worden sind.

  end
end