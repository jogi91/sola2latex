require "kopierer"
require "tools"
include Tools
Shoes.app(:title => "Solablock2LaTeX", :width => 800, :height => 800, :resizable => false) do
  datenhandler = Kopierer.new
  #Hauptflow, hier kommt alles rein
  flow(:scroll => false, :width => 800, :height => 800) do



    #Warnhinweis 
    @hinweis = stack(:width => 800, :height => 800, :margin_left => 40, :margin_right => 40, :margin_top => 20) do
      debug @editor.inspect
      flow do
        banner "Solablock2LaTeX"
        logo = image "Jublalogo.png"
        logo.height = 75
        logo.move(580,1)
      end
      para "Dieses Programm wird so wie es ist, ohne jegliche Garantien von mir zur Verfügung gestellt. Insbesondere wird keine Garantie für Datenverluste oder Programmabstürze übernommen."
      para "Es kann frei benutzt, weitergegeben und verändert werden, solange es weiterhin frei für jeden nutzbar bleibt, auch mit den neuen Änderungen"
      para "Der Zweck dieses Programms ist es, Sommerlagerblöcke nach den Vorlagen zu erstellen. Wenn alle Felder Ordnungsgemäss ausgefüllt werden, wird ein LaTeX-Dokument gespeichert, dass dann in eine PDF-Datei umgewandelt werden kann."
      para link("Dieses Programm im Web", :click => "http://github.com/jogi91/sola2latex")
      @knopf = button("OK"){
        #Wenn der Knopf gedrückt wird, erste Werte einlesen
        # Werte für die Grundlegenden Blockdaten abfragen
        parameter = ["Blockname", "J+S-Nummer", "Leitung", "Teilnehmer", "Ort", "Datum", "Zeit"]
        datenhandler.basisparameter = parameter
        parameterwerte = Array.new(parameter.size){String.new}
        debug parameterwerte.inspect
        parameter.each_index{|index|
          begin
            parameterwerte[index] = ask("#{parameter[index]}?")
            if check_basics(parameter[index],parameterwerte[index]) == false
              raise "Kein gültiger wert"
            end
          rescue
            alert "Kein gültiger Wert eingegeben"
            retry
          end
          
          
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

    end
    #Hinweis fertig
    
    
    
    #Ziele-Fenster
    @zielestack = stack(:title => "Blockziele", :height => 800, :width => 800) do
      ziele = Array.new
      stack(:width => 800, :margin_left => 40, :margin_right => 40) do
        title "Blockziele"
        para "Hier werden die Ziele eingegeben. Bitte immer nur ein Ziel in die Textbox kopieren und den hinzufügen-Button drücken. Wenn man das letzte Ziel hinzugefügt hat, kann der Vorgang durch klicken auf Fertig abgeschlossen werden."
        ziel = edit_box(:width => 1.0, :height => 300)
        keypress do |k|
          debug ziel.inspect
          if k == :alt_v
            ziel.text += self.clipboard
          end
        end
        flow do
          button("hinzufügen"){
            if ziel.text != ""
              ziele.push ziel.text
              ziel.text = ""
            else
              alert("Bitte zuerst einen Text ins Textfeld eingeben.")
            end
          }
          i = button("Fertig"){
            if ziel.text != ""
              alert("Bitte das aktuelle Ziel noch hinzufügen oder die Inhalte der Textbox löschen")
            elsif ziele.length == 0
              alert("Bitte mindestens ein Ziel eingeben")
            else
              datenhandler.ziele = ziele
              @zielestack.remove
            end
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
        para "Hier wird das Sicherheitskonzept eingegeben. Man geht hier genau so wie beim Eingeben der Ziele vor. Jeder Teil des Sicherheitskonzepts, den man hinzufügt, wird zu einem Listenpunkt"
        sicherheit = edit_box(:width => 1.0, :height => 300)
        keypress do |k|
          if k == :alt_v
            sicherheit.text += self.clipboard
          end
        end
        flow do
          button("hinzufügen"){
            if sicherheit.text != ""
              sicherheiten.push sicherheit.text
              sicherheit.text = ""
            else
              alert("Bitte zuerst einen Text ins Textfeld eingeben.")
            end
          }
          i = button("Fertig"){
            if sicherheit.text != ""
              alert("Bitte zuerst den aktuellen Punkt noch hinzufügen")
            elsif sicherheiten.length == 0
              alert("Es wurde nichts eingegeben. Macht euch Gedanken über die Sicherheit. Ihr seid doch schliesslich verantwortungsbewusste Jubla-Leiter")
            else
              datenhandler.sicherheit = sicherheiten
              @sicherheitskonzeptstack.remove
            end
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
        material = edit_box(:width => 1.0, :height => 300)
        keypress do |k|
          if k == :alt_v
            material.text += self.clipboard
          end
        end
        i = button("Fertig"){
          if material.text == ""
            sicher = confirm("Wird wirklich kein Material gebraucht?")
          end
          if material.text != "" or sicher == true
            datenhandler.material = material.text
            @materialstack.remove
          end
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
  #Hauptflow fertig
end
