#Diese Klasse soll den Vorlagentext komplett enthalten, da ich nicht davon ausgehen kann, dass der LaTeX-Code von Shoes mitgepackt wird.
#Er wird die Daten entgegennehmen, sie komplett in den Block einfügen und den kompletten LaTeX-Code dann ausgeben können.
class Kopierer
  attr_accessor :basisparameter, :basisparameterwerte, :ziele, :sicherheit
  attr_accessor :einstieg, :hauptteil, :ausstieg, :kommentare_einstieg, :kommentare_hauptteil, :kommentare_ausstieg
  def initialize
    @einstieg, @hauptteil, @ausstieg, @kommentare_einleitung, @kommentare_hauptteil, @kommentare_ausstieg = ""
  end  
  
end