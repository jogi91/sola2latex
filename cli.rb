require "basisdaten"
include Basisdaten


puts "---- Solablock Kommandozeileninterface ----\n\n"



puts "Dieses Programm wird so wie es ist, ohne jegliche Garantien von mir zur Verfügung gestellt. Insbesondere wird keine Garantie für Datenverluste oder Programmabstürze übernommen."
puts "Es kann frei benutzt, weitergegeben und verändert werden, solange es weiterhin frei für jeden nutzbar bleibt, auch mit den neuen Änderungen"
puts "Der Zweck dieses Programms ist es, Sommerlagerblöcke nach den Vorlagen zu erstellen. Wenn alle Felder Ordnungsgemäss ausgefüllt werden, wird ein LaTeX-Dokument gespeichert, dass dann in eine PDF-Datei umgewandelt werden kann."
puts "Dieses Programm im Web: "+"http://github.com/jogi91/sola2latex"


datei = File.open("latex/vorlage.tex", "r")
vorlage = datei.read
datei.close

basisdaten = Basisdaten.basisdatenabfrage
ziele = Basisdaten.zielabfrage
