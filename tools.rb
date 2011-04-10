module Tools
  # Zeigt eine Hilfe zum Benutzen des Editors an, Text muss noch geschrieben werden
  def display_help
    dialog do
      banner "Rettung Naht!"
    end
  end
  
  # prueft Basisblockdaten
  def check_basics(parameter, wert)
    case parameter
    when "Zahl"
      if wert.to_i.to_s == wert
        return true
      else
        return false
      end
    # Wenn kein expliziter Test für einen Parameter existiert, nur leerstrings, oder nil zurückweisen
    else
      if wert == nil or wert == ""
        return false
      else 
        return true
      end
    end
  end
  
  
  # Blockdaten anzeigen
  def display_data(kopierer)
    dialog do
      stack do
        title "Blockdaten"
        kopierer.basisparameter.each_index do |i|
          flow { 
            caption kopierer.basisparameter[i]+": "+kopierer.basisparameterwerte[i]
          }
        end
        title "Ziele"
        kopierer.ziele.each {|ziel|
          para "- "+ziel
        }
        title "Sicherheitskonzept"
        kopierer.sicherheit.each { |sicher| 
          para "- "+sicher
        }
        title "Material"
        para kopierer.material
      end
    end
  end
end