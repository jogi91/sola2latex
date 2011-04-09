module Tools
  # Zeigt eine Hilfe zum Benutzen des Editors an, Text muss noch geschrieben werden
  def display_help
    dialog do
      banner "Rettung Naht!"
    end
  end
  
  #
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