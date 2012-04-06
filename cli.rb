require "basisdaten"
include Basisdaten
require "blockbeschrieb"
include	Blockbeschrieb

puts "---- Solablock Kommandozeileninterface ----\n\n"



puts "Dieses Programm wird so wie es ist, ohne jegliche Garantien von mir zur Verfügung gestellt. Insbesondere wird keine Garantie für Datenverluste oder Programmabstürze übernommen."
puts "Es kann frei benutzt, weitergegeben und verändert werden, solange es weiterhin frei für jeden nutzbar bleibt, auch mit den neuen Änderungen"
puts "Der Zweck dieses Programms ist es, Sommerlagerblöcke nach den Vorlagen zu erstellen. Wenn alle Felder Ordnungsgemäss ausgefüllt werden, wird ein LaTeX-Dokument gespeichert, dass dann in eine PDF-Datei umgewandelt werden kann."
puts "Dieses Programm im Web: "+"http://github.com/jogi91/sola2latex"


datei = File.open("latex/vorlage.tex", "r")
vorlage = datei.read
datei.close

#basisdaten = Basisdaten.basisdatenabfrage
#ziele = Basisdaten.zielabfrage
#siko = Basisdaten.sikoabfrage

result, blocknummer = fillTemplate vorlage

displayDisclaimer
result.gsub!(/EINSTIEG/, getsBeschrieb("Einstieg")) 
result.gsub!(/HAUPTTEIL/, getsBeschrieb("Hauptteil")) 
result.gsub!(/AUSSTIEG/, getsBeschrieb("Ausstieg")) 

puts "save to output/"+blocknummer.gsub(/\s+/,"")+".tex"
out =File.open("output/"+blocknummer.gsub(/\s+/,"")+".tex", "w")
out << result
out.close

`./doublebackslash.sh`
