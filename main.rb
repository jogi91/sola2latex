require "kopierer"
require "tools"
include Tools
Shoes.app(:title => "Solablock2LaTeX", :width => 800, :height => 800, :resizable => false) do
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
          parameterwerte[index] = ask("#{parameter[index]}?")
          @hinweis.append do #Anderenfalls würden die paragraphs ausserhalb von @hinweis platziert werden.
            para "#{parameter[index]}: #{parameterwerte[index]}"
          end
        }
        datenhandler.basisparameterwerte = parameterwerte #Die Parameterwerte werden in den Kopierer geladen
        debug "Parameterwerte:"
        debug parameterwerte.inspect
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
    #Sicherheitskonzeptfenster fertig
    
    #Material-Fenster
    @materialstack = stack(:title => "Material", :height => 800, :width => 800) do
      stack(:width => 800, :margin_left => 40, :margin_right => 40) do
        title "Material"
        para "Bitte hier das Material durch Kommas getrennt aufführen"
        material = edit_box(:width => 1.0)
        keypress do |k|
          if k == :alt_v
            material.text += self.clipboard
          end
        end
        i = button("Fertig"){
          datenhandler.material = material.text
          @materialstack.remove
        }
      end
    end
    #Materialfenster fertig  
    
    #editor, wird am Anfang noch nicht angezeigt
    @editor = stack(:width => 800, :height => 800, :margin_left => 40, :margin_right => 40) do
      banner "Editor", :align => "center"
      #Buttonleiste des Editors
      flow do
        buttons = Array.new
        buttons[0] = button("Blockinfos"){display_data(datenhandler)}
        buttons[1] = button("Hilfe"){display_help}
        #Die folgenden drei Buttons switchen die Ansicht zwischen Einstieg, Hauptteil und Schluss. Der Text wird jeweils in den Datenhandler gespeichert und dann wieder rausgeholt
        buttons[2] = button("Einstieg"){
          debug datenhandler.einstieg
          case @sektion.text
          when "Einstieg"
            datenhandler.einstieg = @text.text
            datenhandler.kommentare_einstieg = @bemerkungstext.text
          when "Hauptteil"
            datenhandler.hauptteil = @text.text
            datenhandler.kommentare_hauptteil = @bemerkungstext.text
          when "Ausstieg"
            datenhandler.ausstieg = @text.text
            datenhandler.kommentare_ausstieg = @bemerkungstext.text
          end
          @sektion.replace("Einstieg")
          @text.text = datenhandler.einstieg 
          @bemerkungstext.text = datenhandler.kommentare_einstieg
        }
        buttons[3] = button("Hauptteil"){
          case @sektion.text
          when "Einstieg"
            datenhandler.einstieg = @text.text
            datenhandler.kommentare_einstieg = @bemerkungstext.text
          when "Hauptteil"
            datenhandler.hauptteil = @text.text
            datenhandler.kommentare_hauptteil = @bemerkungstext.text
          when "Ausstieg"
            datenhandler.ausstieg = @text.text
            datenhandler.kommentare_ausstieg = @bemerkungstext.text
          end
          @text.text = datenhandler.hauptteil
          @bemerkungstext.text = datenhandler.kommentare_hauptteil
          @sektion.replace("Hauptteil")
        }
        buttons[4] = button("Ausstieg"){
          case @sektion.text
          when "Einstieg"
            datenhandler.einstieg = @text.text
            datenhandler.kommentare_einstieg = @bemerkungstext.text
          when "Hauptteil"
            datenhandler.hauptteil = @text.text
            datenhandler.kommentare_hauptteil = @bemerkungstext.text
          when "Ausstieg"
            datenhandler.ausstieg = @text.text
            datenhandler.kommentare_ausstieg = @bemerkungstext.text
          end
          @text.text = datenhandler.ausstieg
          @bemerkungstext.text = datenhandler.kommentare_ausstieg
          @sektion.replace("Ausstieg")
        }
        #
        buttons[5] = button("Speichern"){
          #Den aktuellen Inhalt der Textboxen in den datenhandler kopieren, dann speichern
          case @sektion.text
          when "Einstieg"
            datenhandler.einstieg = @text.text
            datenhandler.kommentare_einstieg = @bemerkungstext.text
          when "Hauptteil"
            datenhandler.hauptteil = @text.text
            datenhandler.kommentare_hauptteil = @bemerkungstext.text
          when "Ausstieg"
            datenhandler.ausstieg = @text.text
            datenhandler.kommentare_ausstieg = @bemerkungstext.text
          end
          datenhandler.speichern
        }
        buttons.each{ |b|
          b.style(:width => 120)
        }
      end
      #Buttonleiste fertig
      @sektion = caption "Einstieg"
      @text = edit_box(:width => 1.0, :height => 400)
      bemerkungen = caption "Bemerkungen"
      @bemerkungstext = edit_box(:width => 1.0, :height => 200)
    end


  end
end
